import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScrollViewWithAbsorberCase extends StatefulWidget {
  static String routeName = 'CustomScrollViewWithAbsorberCase';
  const CustomScrollViewWithAbsorberCase({super.key});

  @override
  State<CustomScrollViewWithAbsorberCase> createState() =>
      _CustomScrollViewWithAbsorberCaseState();
}

class _CustomScrollViewWithAbsorberCaseState
    extends State<CustomScrollViewWithAbsorberCase> {
  Random random = Random();
  final ScrollController _controller = ScrollController();
  double topBarOpacity = 0;
  final ValueNotifier<double> _bgFixedNotifier = ValueNotifier<double>(0);
  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      print('object');
      _bgFixedNotifier.value = _controller.offset.clamp(0, 200) / 200 * 0.80;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.grey.shade200,
        child: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            SliverOverlapAbsorber(
                handle: SliverOverlapAbsorberHandle(),
                sliver: ValueListenableBuilder(
                  valueListenable: _bgFixedNotifier,
                  builder: (BuildContext context, value, Widget? child) {
                    return SliverAppBar(
                      pinned: true,
                      leading: Container(),
                      backgroundColor: Colors.white.withOpacity(value),
                      elevation: 0,
                      // expandedHeight: 30,
                      systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        statusBarBrightness: Brightness.light,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      flexibleSpace: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
                        child: Center(
                          child: Container(
                              height: 44,
                              child: const Center(
                                child: Text(
                                  'Title',
                                ),
                              )),
                        ),
                      ),
                    );
                  },
                )),
            SliverToBoxAdapter(
              child: Image.asset(
                "./assets/images/sky.webp",
                fit: BoxFit.cover,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: Container(
                  color: Colors.indigo.shade300,
                  child: Center(child: const Text('content')),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Colors.cyan.shade200,
                        child: Center(child: const Text('content')),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.amber.shade200,
                        child: Center(child: const Text('content')),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // SliverPersistentHeader(
            //     pinned: true,
            //     delegate: TabBarDelegate(
            //         child: Container(
            //       height: 100,
            //       child: Row(
            //         children: [
            //           ...List<Widget>.generate(
            //               4,
            //               (index) => Expanded(
            //                     child: Container(
            //                       color: Colors.white,
            //                       child: Center(child: Text('Tab $index')),
            //                     ),
            //                   ))
            //         ],
            //       ),
            //     ))),
            SliverList.builder(itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 50,
                  color: Colors.blue.withOpacity(random.nextDouble()),
                  child: Text('data #$index'));
            }),
          ],
        ),
      ),
    );
  }
}

class StatusBarWidget extends StatelessWidget {
  const StatusBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.w,
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          color: Colors.white,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[Icon(Icons.search), Text('searh')],
          ),
        ),
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  TabBarDelegate({required this.child});
  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
