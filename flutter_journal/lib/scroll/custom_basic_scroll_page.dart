import 'package:flutter/material.dart';

class CustomBasicScrollPage extends StatefulWidget {
  static String routeName = 'CustomBasicScrollPage';
  const CustomBasicScrollPage({super.key});

  @override
  State<CustomBasicScrollPage> createState() => _CustomBasicScrollPageState();
}

class _CustomBasicScrollPageState extends State<CustomBasicScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          const SliverAppBar(),
          SliverToBoxAdapter(
            child: Container(
              child: const Text(' text '),
            ),
          ),
          SliverList.builder(
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return Text('data $index');
              }),
        ],
      ),
    );
  }
}
