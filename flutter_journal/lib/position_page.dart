import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// The demo ref
/// https://juejin.cn/post/6844903764168704007
class WidgetPositionPage extends StatefulWidget {
  static String routeName = 'WidgetPositionPage';

  const WidgetPositionPage({super.key});

  @override
  State<WidgetPositionPage> createState() => _WidgetPositionPageState();
}

class _WidgetPositionPageState extends State<WidgetPositionPage> {
  final GlobalKey _itemKey = GlobalKey();

  String desc = '';
  void _scrollItemIntoView() {
    final RenderBox renderBox =
        _itemKey.currentContext?.findRenderObject() as RenderBox;
    renderBox.localToGlobal(Offset.zero);

    final RenderAbstractViewport viewport =
        RenderAbstractViewport.of(renderBox);

    /// Distance between top edge of screen and MyWidget bottom edge
    RevealedOffset offsetToRevealLeading =
        viewport.getOffsetToReveal(renderBox, 0.0, rect: Rect.zero);
    setState(() {
      desc = "$desc\n offsetToRevealLeading ${offsetToRevealLeading.offset}";
    });

    /// Distance between bottom edge of screen and MyWidget top edge
    RevealedOffset offsetToRevealTrailingEdge =
        viewport.getOffsetToReveal(renderBox, 1.0, rect: Rect.zero);
    setState(() {
      desc =
          "$desc\n offsetToRevealTrailingEdge ${offsetToRevealTrailingEdge.offset}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: 1100,
            itemExtent: 30,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  if (index == 10) {
                    _scrollItemIntoView();
                  }
                },
                child: Container(
                    key: index == 10 ? _itemKey : null,
                    child: Text('Item $index')),
              );
            },
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(child: Text(desc)),
              ))
        ],
      ),
    );
  }
}
