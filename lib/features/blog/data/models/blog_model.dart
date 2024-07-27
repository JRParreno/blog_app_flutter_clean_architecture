import 'dart:convert';

import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  const BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.updatedAt,
    required super.topics,
    super.posterName,
  });

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    DateTime? updatedAt,
    List<String>? topics,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'updated_at': updatedAt.toIso8601String(),
      'topics': topics,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
      topics: List<String>.from(map['topics'] ?? []),
    );
  }

  factory BlogModel.fromJson(Map<String, dynamic> source) =>
      BlogModel.fromMap(source);
}

class BlogModelCodec extends Codec<BlogModel, Map<String, dynamic>> {
  @override
  Converter<Map<String, dynamic>, BlogModel> get decoder => BlogModelDecoder();

  @override
  Converter<BlogModel, Map<String, dynamic>> get encoder => BlogModelEncoder();
}

class BlogModelDecoder extends Converter<Map<String, dynamic>, BlogModel> {
  @override
  BlogModel convert(Map<String, dynamic> input) {
    return BlogModel.fromMap(input);
  }
}

class BlogModelEncoder extends Converter<BlogModel, Map<String, dynamic>> {
  @override
  Map<String, dynamic> convert(BlogModel input) {
    return input.toMap();
  }
}
