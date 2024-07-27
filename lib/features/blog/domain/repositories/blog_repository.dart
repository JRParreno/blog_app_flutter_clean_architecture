import 'dart:io';

import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/features/blog/data/models/blog_model.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });

  Future<Either<Failure, List<BlogModel>>> getAllBlogs();
}
