import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BasicScrollPage extends StatefulWidget {
  static String routeName = 'BasicScrollPage';
  const BasicScrollPage({super.key});

  @override
  State<BasicScrollPage> createState() => _BasicScrollPageState();
}

class _BasicScrollPageState extends State<BasicScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text('Text $index'));
          }),
    );
  }
}

