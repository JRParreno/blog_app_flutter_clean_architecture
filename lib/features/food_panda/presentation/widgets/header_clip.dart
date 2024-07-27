// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/theme/app_pallete.dart';
import 'package:flutter_blog_app/features/food_panda/presentation/widgets/custom_shape.dart';

class HeaderClip extends StatelessWidget {
  const HeaderClip({
    Key? key,
    required this.backgroundUrl,
    required this.context,
  }) : super(key: key);

  final String backgroundUrl;
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    final textTheme = Theme.of(context).textTheme;
    return ClipPath(
      clipper: CustomShape(),
      child: Stack(
        children: [
          SizedBox(
            height: 275,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/transparent.png',
              image: backgroundUrl,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            height: 275,
            color: AppPallete.gradient1.withOpacity(0.7),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + kToolbarHeight,
            ),
            child: Column(
              children: [
                const SizedBox(height: 4.0),
                Text(
                  "Thi is a title only",
                  style: textTheme.displayMedium?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppPallete.greyColor),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Sample: 10:55PK",
                      style: textTheme.headlineMedium
                          ?.copyWith(color: AppPallete.greyColor),
                      strutStyle: const StrutStyle(forceStrutHeight: true),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_rate_rounded,
                      size: 16,
                      color: AppPallete.greyColor,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '5/5',
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppPallete.greyColor,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      "(5)",
                      style: textTheme.bodySmall?.copyWith(
                        color: AppPallete.greyColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
