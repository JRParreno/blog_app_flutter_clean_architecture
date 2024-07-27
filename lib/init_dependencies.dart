import 'package:flutter_blog_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:flutter_blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_blog_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:flutter_blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:flutter_blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  await dotenv.load(fileName: '.env');

  final supabase = await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator<SupabaseClient>(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    // Usecase
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  // Datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<BlogRepository>(
        () => BlogRepositoryImpl(serviceLocator()))
    // Usecase
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => GetAllBlogs(serviceLocator()))

    // Bloc
    ..registerFactory(
      () =>
          BlogBloc(uploadBlog: serviceLocator(), getAllBlogs: serviceLocator()),
    );
}
