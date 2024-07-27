import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onBlogFetchAllBlogs);
  }

  Future<void> _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());

    final response = await _uploadBlog(UploadBlogParams(
      image: event.image,
      title: event.title,
      content: event.content,
      posterId: event.posterId,
      topics: event.topics,
    ));

    response.fold(
      (l) => emit(BlogFailure(l.messsage)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  Future<void> _onBlogFetchAllBlogs(
      BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());

    final response = await _getAllBlogs(NoParams());

    response.fold(
      (l) => emit(BlogFailure(l.messsage)),
      (r) => emit(BlogDisplaytSuccess(r)),
    );
  }
}
