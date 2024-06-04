import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BasicPinnedPage extends StatefulWidget {
  static String routeName = 'BasicPinnedPage';

  const BasicPinnedPage({super.key});

  @override
  State<BasicPinnedPage> createState() => _BasicPinnedPageState();
}

class _BasicPinnedPageState extends State<BasicPinnedPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        cacheExtent: 0,
        // physics: RangeMaintainingScrollPhysics(),
        slivers: <Widget>[
          // const SliverAppBar(
          //   pinned: true,
          // ),
           SliverList.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
            return Text('text $index');
          }),
          SliverToBoxAdapter(
            child: Align(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.orange.shade100,
                child: const Text('orange not pin'),
              ),
            ),
          ),
          // SliverPersistentHeader(
          //   delegate: _MySliverPersistentHeaderDelegate(),
          //   pinned: true,
          // ),
          //   SliverPersistentHeader(
          //   delegate: _MySliverPersistentHeaderDelegate(),
          //   pinned: true,
          // ),
          SliverList.builder(itemBuilder: (BuildContext context, int index) {
            return Text('text $index');
          })
        ],
      ),
    );
  }
}

class _MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 60.0;

  @override
  double get maxExtent => 60.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          'SliverPersistentHeader',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_MySliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
