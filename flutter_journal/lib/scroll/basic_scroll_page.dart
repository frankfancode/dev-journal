import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_journal/utils.dart';

class BasicScrollPage extends StatefulWidget {
  static String routeName = 'BasicScrollPage';
  const BasicScrollPage({super.key});

  @override
  State<BasicScrollPage> createState() => _BasicScrollPageState();
}

class _BasicScrollPageState extends State<BasicScrollPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      Utils.log('${_scrollController.position.maxScrollExtent}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: 10000,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 10.1*index*2,
              child: ListTile(title: Text('Text $index')));
          }),
    );
  }
}
