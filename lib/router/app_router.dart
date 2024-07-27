import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:flutter_blog_app/features/blog/data/models/blog_model.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter_blog_app/router/app_routes.dart';
import 'package:flutter_blog_app/router/extra_codecs.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/index.dart';
import '../features/blog/presentation/pages/index.dart';

/// Contains all of the app routes configurations
class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutes.login.path,
    redirect: (context, state) {
      final appUserState = context.read<AppUserCubit>().state;
      final loginPath = AppRoutes.login.path;

      final bool loggingIn = state.matchedLocation == loginPath;

      if (appUserState is AppUserLoggedIn && loggingIn) {
        return AppRoutes.foodPanda.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signup.path,
        name: AppRoutes.signup.name,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: AppRoutes.blog.path,
        name: AppRoutes.blog.name,
        builder: (context, state) => const BlogPage(),
        routes: [
          GoRoute(
            path: AppRoutes.blogAdd.path,
            name: AppRoutes.blogAdd.name,
            builder: (context, state) => const AddNewBlogPage(),
          ),
          GoRoute(
            path: AppRoutes.blogDetail.path,
            name: AppRoutes.blogDetail.name,
            builder: (context, state) {
              final blog = state.extra as Blog;

              return BlogViewerPage(blog: blog);
            },
          )
        ],
      ),
      GoRoute(
        path: AppRoutes.foodPanda.path,
        name: AppRoutes.foodPanda.name,
        builder: (context, state) => const BlogPage(),
      ),
    ],
    extraCodec: const MyExtraCodec(),
  );
}
