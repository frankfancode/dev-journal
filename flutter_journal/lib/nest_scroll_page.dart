import 'package:flutter/material.dart';
/// learn from https://book.flutterchina.club/chapter6/nestedscrollview.html#_6-12-3-sliverappbar
class NestScrollPage extends StatefulWidget {
  static const String routeName = 'NestScrollPage';

  const NestScrollPage({super.key});

  @override
  State<NestScrollPage> createState() => _NestScrollPageState();
}

class _NestScrollPageState extends State<NestScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: NestedScrollView(headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled) {
      return // 返回一个 Sliver 数组给外部可滚动组件。
          <Widget>[
        SliverOverlapAbsorber(
          sliver: SliverAppBar(
            floating: true,
            snap: true,
            expandedHeight: 200,
            forceElevated: innerBoxIsScrolled,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "./assets/images/sea.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        // SliverFixedExtentList.builder(
        //     itemCount: 30,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Text("sliver $index");
        //     },
        //     itemExtent: 30)
      ];
    }, body: Builder(builder: (BuildContext context) {
      return CustomScrollView(slivers: <Widget>[
        SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
        SliverFixedExtentList.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return Text("sliver $index");
            },
            itemExtent: 30),
      ]);
    })));
  }
}
