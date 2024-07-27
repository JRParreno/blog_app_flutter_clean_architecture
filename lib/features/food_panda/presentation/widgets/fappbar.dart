import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/theme/app_pallete.dart';

class Fappbar extends SliverAppBar {
  const Fappbar({
    super.key,
    required this.tabController,
    required this.context,
    required this.mainTitle,
    required this.subtitle,
    required this.image,
    required this.tabTitles,
    required this.onTapBack,
    required this.onTapShare,
    required this.onCollapsed,
    required this.onTap,
    required this.isCollapsed,
  }) : super(
          pinned: true,
          forceElevated: true,
          elevation: 4.0,
          expandedHeight: 230,
        );

  final BuildContext context;
  final VoidCallback onTapBack;
  final VoidCallback onTapShare;
  final TabController tabController;
  final String mainTitle;
  final String subtitle;
  final List<String> tabTitles;
  final String image;
  final bool isCollapsed;
  final void Function(int index) onTap;
  final void Function(bool isCollapsed) onCollapsed;

  @override
  Color? get backgroundColor => AppPallete.whiteColor;

  @override
  Widget? get leading {
    return IconButton(
      onPressed: onTapBack,
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.red,
      ),
    );
  }

  @override
  List<Widget>? get actions {
    return [
      IconButton(
        onPressed: onTapShare,
        icon: const Icon(
          Icons.share_outlined,
          color: Colors.red,
        ),
      )
    ];
  }

  @override
  Widget? get title {
    final textTheme = Theme.of(context).textTheme;

    return AnimatedOpacity(
      opacity: isCollapsed ? 0 : 1,
      duration: const Duration(milliseconds: 250),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainTitle,
            style: textTheme.titleMedium?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? get bottom {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: AppPallete.whiteColor,
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: -10),
          indicator: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          indicatorColor: Colors.transparent,
          dividerHeight: 0,
          tabAlignment: TabAlignment.start,
          labelColor: AppPallete.whiteColor,
          tabs: tabTitles
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
          onTap: onTap,
        ),
      ),
    );
  }

  @override
  Widget? get flexibleSpace {
    return LayoutBuilder(
      builder: (context, constraints) {
        final top = constraints.constrainHeight();
        final collapsedHight =
            MediaQuery.of(context).viewPadding.top + kToolbarHeight + 48;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          onCollapsed(collapsedHight != top);
        });

        final textTheme = Theme.of(context).textTheme;

        return FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: Column(
            children: [
              Flexible(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppPallete.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    Text(
                      mainTitle,
                      style:
                          textTheme.titleLarge?.copyWith(color: Colors.black),
                    ),
                    Text(
                      subtitle,
                      style:
                          textTheme.labelMedium?.copyWith(color: Colors.black),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
