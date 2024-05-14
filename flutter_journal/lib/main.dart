import 'package:flutter/material.dart';
import 'package:flutter_journal/nest_scroll_page.dart';
import 'package:flutter_journal/pin_header_page.dart';
import 'package:flutter_journal/position_page.dart';
import 'package:flutter_journal/pull_refresh_page.dart';
import 'package:flutter_journal/snap_appbar_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_sliver_page.dart';

void main() {
  runApp(const MyApp());
}

final Map<String, StatefulWidget Function(BuildContext context)> routes =
    <String, StatefulWidget Function(BuildContext context)>{
  CustomSliverPage.routeName: (BuildContext context) =>
      const CustomSliverPage(),
  NestScrollPage.routeName: (BuildContext context) => const NestScrollPage(),
  PullRefreshPage.routeName: (BuildContext context) => const PullRefreshPage(),
  PinHeaderPage.routeName: (BuildContext context) => const PinHeaderPage(),
  SliverOverlapAbsorberUsagePage.routeName: (BuildContext context) =>
      const SliverOverlapAbsorberUsagePage(),
  WidgetPositionPage.routeName: (BuildContext context) =>
      const WidgetPositionPage(),
};

final List<String> routeList = routes.keys.toList();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(750 / 2, 1334 / 2),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: routes,
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, routeList[index]);
                setState(() {});
              },
              child: Container(
                color: Colors.blueAccent.shade100,
                padding: const EdgeInsets.all(8),
                child: Text(routeList.elementAt(index)),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.white,
              height: 2,
            );
          },
          itemCount: routeList.length),
    );
  }
}
