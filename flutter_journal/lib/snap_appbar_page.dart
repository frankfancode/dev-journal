import 'package:flutter/material.dart';
import 'package:flutter_journal/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// This demo fomr this post https://book.flutterchina.club/chapter6/nestedscrollview.html#_6-12-1-nestedscrollview
class SliverOverlapAbsorberUsagePage extends StatefulWidget {
  static String routeName =
      const SliverOverlapAbsorberUsagePage().runtimeType.toString();

  const SliverOverlapAbsorberUsagePage({super.key});

  @override
  State<SliverOverlapAbsorberUsagePage> createState() =>
      _SliverOverlapAbsorberUsagePageState();
}

class _SliverOverlapAbsorberUsagePageState
    extends State<SliverOverlapAbsorberUsagePage> {
  late SliverOverlapAbsorberHandle handle;
  bool useSliverOverlapAbsorber = true;
  bool useSliverOverlapInjector = true;

  void onOverlapChanged() {
    Utils.log('overlap length ${handle.layoutExtent}');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              handle = NestedScrollView.sliverOverlapAbsorberHandleFor(context);
              handle.removeListener(onOverlapChanged);
              handle.addListener(onOverlapChanged);
              return <Widget>[
                if (useSliverOverlapAbsorber)
                  SliverOverlapAbsorber(
                    handle: handle,
                    sliver: SliverAppBar(
                      floating: true,
                      snap: true,
                      pinned: true, // 放开注释，然后看日志
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                          "./assets/images/sea.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      forceElevated: innerBoxIsScrolled,
                    ),
                  )
                else
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    pinned: true, // 放开注释，然后看日志
                    expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                        "./assets/images/sea.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    forceElevated: innerBoxIsScrolled,
                  ),
              ];
            },
            body: Builder(builder: (BuildContext context) {
              return CustomScrollView(
                slivers: <Widget>[
                  if (useSliverOverlapInjector)
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                  SliverList.builder(
                      itemBuilder: (BuildContext context, int index) {
                    return Text('$index');
                  })
                ],
              );
            }),
          ),
          Positioned(
              right: 0,
              top: 1.sh / 2,
              child: Container(
                padding: EdgeInsets.all(8.w),
                color: Colors.grey.shade100,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: useSliverOverlapAbsorber,
                              onChanged: (bool? value) {
                                setState(() {
                                  useSliverOverlapAbsorber = value ?? true;
                                });
                              }),
                          const Text('useSliverOverlapAbsorber')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: useSliverOverlapInjector,
                              onChanged: (bool? value) {
                                setState(() {
                                  useSliverOverlapInjector = value ?? true;
                                });
                              }),
                          const Text('useSliverOverlapInjector')
                        ],
                      )
                    ]),
              ))
        ],
      ),
    );
  }
}
