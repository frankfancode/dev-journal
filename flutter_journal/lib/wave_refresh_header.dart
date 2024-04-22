import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_journal/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// The duration of the ScaleTransition that starts when the refresh action
// has completed.
const Duration _kIndicatorScaleDuration = Duration(milliseconds: 200);

class WaveHeader extends Header {

  WaveHeader({
    this.key,
    this.displacement = 40.0,
    this.waveColor,
    this.textColor,
    this.backgroundColor,
    Duration? completeDuration = const Duration(seconds: 1),
    super.enableHapticFeedback,
  }): super(
    float: false,
    extent: 50.w,
    triggerDistance: 50.w,
    completeDuration: completeDuration == null
        ? const Duration(milliseconds: 300,)
        : completeDuration + const Duration(milliseconds: 300,),
    enableInfiniteRefresh: false,
  );
  final Key? key;
  final double displacement;
  final Color? backgroundColor;
  final Color? waveColor;
  final Color? textColor;

  final LinkHeaderNotifier linkNotifier = LinkHeaderNotifier();

  @override
  Widget contentBuilder(BuildContext context, RefreshMode refreshState,
      double pulledExtent, double refreshTriggerPullDistance,
      double refreshIndicatorExtent, AxisDirection axisDirection,
      bool float, Duration? completeDuration, bool enableInfiniteRefresh,
      bool success, bool noMore) {
    linkNotifier.contentBuilder(context, refreshState, pulledExtent,
        refreshTriggerPullDistance, refreshIndicatorExtent, axisDirection,
        float, completeDuration, enableInfiniteRefresh, success, noMore);
    return WaveHeaderWidget(
      key: key,
      displacement: displacement,
      waveColor: waveColor,
      textColor: textColor,
      backgroundColor: backgroundColor,
      linkNotifier: linkNotifier,
    );
  }
}
class WaveHeaderWidget extends StatefulWidget {

  const WaveHeaderWidget({
    super.key,
    this.displacement,
    this.waveColor,
    this.textColor,
    this.backgroundColor,
    required this.linkNotifier,
  });
  final double? displacement;
  final Color? waveColor;
  final Color? textColor;
  final Color? backgroundColor;
  final LinkHeaderNotifier linkNotifier;

  @override
  WaveHeaderWidgetState createState() {
    return WaveHeaderWidgetState();
  }
}
class WaveHeaderWidgetState extends State<WaveHeaderWidget>
    with TickerProviderStateMixin<WaveHeaderWidget>{

  RefreshMode get _refreshState => widget.linkNotifier.refreshState;
  double get _pulledExtent => widget.linkNotifier.pulledExtent;
  Duration? get _completeDuration =>
      widget.linkNotifier.completeDuration;
  AxisDirection get _axisDirection => widget.linkNotifier.axisDirection;

  AnimationController? _scaleController;
  AnimationController? _waveHeaderController;

  @override
  void initState() {
    super.initState();
    Utils.log('easy_refresh wave_refresh_header initState');
    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 10));
    _waveHeaderController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
  }

  @override
  void dispose() {
    super.dispose();
    _scaleController?.dispose();
  }

  bool _refreshFinish = false;
  bool get refreshFinish => _refreshFinish;
  set refreshFinish(bool finish) {
    if (_refreshFinish != finish) {
      if (finish) {
        Future<dynamic>.delayed(_completeDuration!
            - const Duration(milliseconds: 300), () {
          if (mounted) {
            _scaleController!.animateTo(1.0, duration: _kIndicatorScaleDuration);
            _scaleController!.reset();
            _scaleController!.forward();
            _waveHeaderController!.reset();
            _waveHeaderController!.forward();
          }
        });
        Future<dynamic>.delayed(_completeDuration!, () {
          _refreshFinish = false;
          _scaleController!.animateTo(0.0, duration: const Duration(milliseconds: 10));
          _scaleController!.reset();
          _scaleController!.forward();
          _waveHeaderController!.reset();
          _waveHeaderController!.forward();
        });
      }
      _refreshFinish = finish;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isVertical = _axisDirection == AxisDirection.down
        || _axisDirection == AxisDirection.up;
    final bool isReverse = _axisDirection == AxisDirection.up
        || _axisDirection == AxisDirection.left;
    if (_refreshState == RefreshMode.refreshed) {
      refreshFinish = true;
    }
    String statusText= '下拉刷新';
    switch(_refreshState) {
      case RefreshMode.armed:
        statusText = '加载中...';
      case RefreshMode.refresh:
        statusText = '加载中...';
      case RefreshMode.refreshed:
        statusText = '加载中...';
      case RefreshMode.done:
        statusText = '加载完成';
      case RefreshMode.inactive:
      case RefreshMode.drag:
        statusText = '下拉刷新';
    }
    return SizedBox(
      height: isVertical ? _refreshState == RefreshMode.inactive
          ? 0.0 : _pulledExtent : double.infinity,
      width: !isVertical ? _refreshState == RefreshMode.inactive
          ? 0.0 : _pulledExtent : double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: isVertical ? isReverse ? 0.0 : null : 0.0,
            bottom: isVertical ? !isReverse ? 0.0 : null : 0.0,
            left: !isVertical ? isReverse ? 0.0 : null : 0.0,
            right: !isVertical ? !isReverse ? 0.0 : null : 0.0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 8.w),
              child: Column(
                children: <Widget>[
                  Text(statusText, style: TextStyle(color: widget.textColor??Colors.white, fontSize: 12.sp),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
