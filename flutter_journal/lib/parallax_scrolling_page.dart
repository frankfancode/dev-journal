import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParallaxScrollingPage extends StatefulWidget {
  static String routeName = 'ParallaxScrollingPage';

  const ParallaxScrollingPage({super.key});

  @override
  State<ParallaxScrollingPage> createState() => _ParallaxScrollingPageState();
}

class _ParallaxScrollingPageState extends State<ParallaxScrollingPage> {
  GlobalKey _parallaxItemKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  double height = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset < 100) {
        setState(() {
          height = min(100, scrollController.offset);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.blue.shade400,
              width: 1.sw,
              height: 100,
            ),
          ),
          SliverToBoxAdapter(
            key: _parallaxItemKey,
            child: Container(
              color: Colors.amber,
              width: 1.sw,
              height: height,
            ),
          ),
          SliverList.builder(itemBuilder: (BuildContext context, int index) {
            return Text('data $index');
          })
        ],
      ),
    );
  }
}
