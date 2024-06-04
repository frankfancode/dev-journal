import 'package:flutter/material.dart';

class CenterOffssetScrollPage extends StatefulWidget {
  static String routeName = 'CenterOffssetScrollPage';
  const CenterOffssetScrollPage({super.key});

  @override
  State<CenterOffssetScrollPage> createState() =>
      _CenterOffssetScrollPageState();
}

class _CenterOffssetScrollPageState extends State<CenterOffssetScrollPage> {
  GlobalKey centerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        center: centerKey,
        slivers: [
          SliverList.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Text('data $index');
              }),
          SliverGrid.builder(
              key: centerKey,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Text('data $index');
              })
        ],
      ),
    );
  }
}
