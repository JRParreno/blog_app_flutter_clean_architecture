import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ScrollTabHeader extends StatefulWidget {
  const ScrollTabHeader({super.key});

  @override
  State<ScrollTabHeader> createState() => _ScrollTabHeaderState();
}

class _ScrollTabHeaderState extends State<ScrollTabHeader> {
  late AutoScrollController _autoScrollController;
  final scrollDirection = Axis.vertical;

  bool isExpaned = true;
  bool get _isAppBarExpanded {
    return _autoScrollController.hasClients &&
        _autoScrollController.offset > (160 - kToolbarHeight);
  }

  @override
  void initState() {
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection,
    )..addListener(
        () => _isAppBarExpanded
            ? isExpaned != false
                ? setState(
                    () {
                      isExpaned = false;
                      print('setState is called');
                    },
                  )
                : {}
            : isExpaned != true
                ? setState(() {
                    print('setState is called');
                    isExpaned = true;
                  })
                : {},
      );
    super.initState();
  }

  Future _scrollToIndex(int index) async {
    await _autoScrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
    _autoScrollController.highlight(index);
  }

  Widget _wrapScrollTag({required int index, required Widget child}) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: _autoScrollController,
      index: index,
      highlightColor: Colors.black.withOpacity(0.1),
      child: child,
    );
  }

  _buildSliverAppbar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 200.0,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Image.network(
            "https://www.smmallsonline.com/wp-content/uploads/2024/06/SUPER-DADS-WEEKEND.jpg"),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: isExpaned ? 0.0 : 1,
          child: DefaultTabController(
            length: 3,
            child: TabBar(
              onTap: (index) async {
                _scrollToIndex(index);
              },
              tabs: List.generate(
                3,
                (i) {
                  return const Tab(
                    text: 'Detail Business',
                  );
                },
              ),
            ),
          ),
        ),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _autoScrollController,
        slivers: <Widget>[
          _buildSliverAppbar(),
          SliverList(
              delegate: SliverChildListDelegate([
            _wrapScrollTag(
                index: 0,
                child: Container(
                  height: 300,
                  color: Colors.red,
                )),
            _wrapScrollTag(
                index: 1,
                child: Container(
                  height: 300,
                  color: Colors.red,
                )),
            _wrapScrollTag(
                index: 2,
                child: Container(
                  height: 300,
                  color: Colors.red,
                )),
          ])),
        ],
      ),
    );
  }
}
