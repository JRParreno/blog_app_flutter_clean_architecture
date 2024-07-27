// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_blog_app/core/theme/app_pallete.dart';

class CategoryTabList extends StatelessWidget {
  const CategoryTabList({
    Key? key,
    required this.tabTtiles,
  }) : super(key: key);

  final List<String> tabTtiles;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabTtiles
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: Chip(
                  label: Text(e),
                  // color: selectedTopics.contains(e)
                  //     ? const WidgetStatePropertyAll(AppPallete.gradient2)
                  //     : null,
                  side: const BorderSide(color: AppPallete.borderColor),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
