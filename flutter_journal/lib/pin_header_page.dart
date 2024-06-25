import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_journal/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinHeaderPage extends StatefulWidget {
  static String routeName = 'PinHeaderPage';

  const PinHeaderPage({super.key});

  @override
  State<PinHeaderPage> createState() => _PinHeaderPageState();
}

class _PinHeaderPageState extends State<PinHeaderPage> {
  final EasyRefreshController _refreshController = EasyRefreshController();
  final ScrollController _controller =
      ScrollController(initialScrollOffset: 88.w);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      Utils.log('_controller.position ${_controller.position.pixels}');
      // _refreshController.callRefresh();
      // if(_controller.position){
      //
      // }
      // _controller.animateTo(offset, duration: duration, curve: curve);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CustomScrollView(
      slivers: <Widget>[
        // SliverOverlapInjector(
        //   // This is the flip side of the SliverOverlapAbsorber
        //   // above.
        //   handle:
        //       NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        // ),

        Builder(builder: (BuildContext context) {
          return MySliverOverlapAbsorber(
            handle: SliverOverlapAbsorberHandle(),
            sliver: SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: MyPinnedPersistentHeaderDelegate(
                height: 88.w,
                child: Container(
                  // padding: EdgeInsets.only(top: 44.w),
                  color: Colors.deepPurpleAccent,
                  child: Container(
                    color: Colors.white30,
                    child: const Center(
                      child: Text('Pinned Sliver'),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),

        SliverToBoxAdapter(
          child: Container(
            height: 120.w,
            color: Colors.amber,
            child: const Text('d1ata'),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 120.w,
            color: Colors.amber,
            child: const Text('d1ata'),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 120.w,
            color: Colors.green,
            child: const Text('d1ata'),
          ),
        ),
        SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(
                child: Container(
              height: 44.w,
              color: Colors.deepPurple,
              child: const Text('tab'),
            ))),
        SliverPersistentHeaderToBox(
            child: Container(
          height: 100,
          color: Colors.black,
        )),
        SliverList.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 50.w,
                color: Colors.blue.withOpacity((((index + 1) % 10) / 10)),
                child: Text('data $index'));
          },
        )
      ],
    ));
  }

  @override
  Widget build1(BuildContext context) {
    return Material(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: MyPinnedPersistentHeaderDelegate(
                  height: 88.w,
                  child: Container(
                    padding: EdgeInsets.only(top: 44.w),
                    color: Colors.transparent,
                    child: const Center(
                      child: Text('Pinned Sliver'),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 120.w,
                color: Colors.amber,
                child: const Text('d1ata'),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 120.w,
                color: Colors.amber,
                child: const Text('d1ata'),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 120.w,
                color: Colors.green,
                child: const Text('d1ata'),
              ),
            ),
            SliverPersistentHeader(
                pinned: true,
                delegate: MySliverPersistentHeaderDelegate(
                    child: Container(
                  height: 44.w,
                  color: Colors.deepPurple,
                  child: const Text('tab'),
                )))
          ];
        },
        body: Builder(builder: (BuildContext context) {
          return CustomScrollView(
            slivers: <Widget>[
              // SliverOverlapInjector(
              //   // This is the flip side of the SliverOverlapAbsorber
              //   // above.
              //   handle:
              //       NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              // ),
              SliverList.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 50.w,
                      color: Colors.blue.withOpacity((((index + 1) % 10) / 10)),
                      child: Text('data $index'));
                },
              )
            ],
          );
        }),
      ),
    );
  }

  Future<bool> _onRefresh() async {
    Utils.log('onRefresh');
    Future.delayed(const Duration(seconds: 3)).then((value) {
      _refreshController.finishRefresh();
    });
    return true;
  }

  /*
  * 加载更多
  */
  Future<void> _loadMore() async {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      _refreshController.finishLoad();
    });
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate({required this.child});

  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Utils.log(
        'MySliverPersistentHeaderDelegate shrinkOffset:$shrinkOffset, overlapsContent:$overlapsContent');
    return child;
  }

  @override
  double get maxExtent => 44.w;

  @override
  double get minExtent => 44.w;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

typedef SliverPersistentHeaderToBoxBuilder = Widget Function(
  BuildContext context,
  double maxExtent, //当前可用最大高度
  bool fixed, // 是否已经固定
);

class SliverPersistentHeaderToBox extends StatelessWidget {
  // 默认构造函数，直接接受一个 widget，不用显式指定高度
  SliverPersistentHeaderToBox({
    super.key,
    required Widget child,
  }) : builder = ((BuildContext a, double b, bool c) => child);

  // builder 构造函数，需要传一个 builder，同样不需要显式指定高度
  const SliverPersistentHeaderToBox.builder({
    super.key,
    required this.builder,
  });

  final SliverPersistentHeaderToBoxBuilder builder;

  @override
  Widget build(BuildContext context) {
    return _SliverPersistentHeaderToBox(
      // 通过 LayoutBuilder接收 Sliver 传递给子组件的布局约束信息
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return builder(
            context,
            constraints.maxHeight,
            //约束中需要传递的额外信息是一个bool类型，表示 Sliver 是否已经固定到顶部
            (constraints as ExtraInfoBoxConstraints<bool>).extra,
          );
        },
      ),
    );
  }
}

class _SliverPersistentHeaderToBox extends SingleChildRenderObjectWidget {
  const _SliverPersistentHeaderToBox({
    super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSliverPersistentHeaderToBox();
  }
}

class _RenderSliverPersistentHeaderToBox extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    Utils.log('constraints $constraints');
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    child!.layout(
      ExtraInfoBoxConstraints(
        //只要 constraints.scrollOffset不为0，则表示已经有内容在当前Sliver下面了，即已经固定到顶部了
        constraints.scrollOffset != 0,
        constraints.asBoxConstraints(
          // 我们将剩余的可绘制空间作为 header 的最大高度约束传递给 LayoutBuilder
          maxExtent: constraints.remainingPaintExtent,
        ),
      ),
      //我们要根据child大小来确定Sliver大小，所以后面需要用到child的大小（size）信息
      parentUsesSize: true,
    );

    // 子节点 layout 后就能获取它的大小了
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }

    // Utils.log('constraints childExtent $childExtent ${offseta.dy}');
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintOrigin: constraints.overlap, // 固定，如果不想固定应该传` - constraints.scrollOffset`
      paintExtent: childExtent,
      maxPaintExtent: childExtent,
    );
    
  }

  // 重要，必须重写，下面介绍。
  @override
  double childMainAxisPosition(RenderBox child) => 100.0;
}

class ExtraInfoBoxConstraints<T> extends BoxConstraints {
  ExtraInfoBoxConstraints(
    this.extra,
    BoxConstraints constraints,
  ) : super(
          minWidth: constraints.minWidth,
          minHeight: constraints.minHeight,
          maxWidth: constraints.maxWidth,
          maxHeight: constraints.maxHeight,
        );

  // 额外的信息
  final T extra;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExtraInfoBoxConstraints &&
        super == other &&
        other.extra == extra;
  }

  @override
  int get hashCode {
    return hashValues(super.hashCode, extra);
  }
}

class MyPinnedPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  MyPinnedPersistentHeaderDelegate({
    required this.height,
    required this.child,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    Utils.log(
        'pin_headeer_page shrinkOffset:$shrinkOffset, overlapsContent:$overlapsContent ');
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(MyPinnedPersistentHeaderDelegate oldDelegate) {
    return height != oldDelegate.height || child != oldDelegate.child;
  }
}

class MySliverOverlapAbsorber extends SingleChildRenderObjectWidget {
  /// Creates a sliver that absorbs overlap and reports it to a
  /// [SliverOverlapAbsorberHandle].
  const MySliverOverlapAbsorber({
    super.key,
    required this.handle,
    Widget? sliver,
  }) : super(child: sliver);

  /// The object in which the absorbed overlap is recorded.
  ///
  /// A particular [SliverOverlapAbsorberHandle] can only be assigned to a
  /// single [MySliverOverlapAbsorber] at a time.
  final SliverOverlapAbsorberHandle handle;

  @override
  RenderSliverOverlapAbsorber createRenderObject(BuildContext context) {
    return RenderSliverOverlapAbsorber(
      handle: handle,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverOverlapAbsorber renderObject) {
    renderObject.handle = handle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<SliverOverlapAbsorberHandle>('handle', handle));
  }
}

/// Handle to provide to a [SliverOverlapAbsorber], a [SliverOverlapInjector],
/// and an [NestedScrollViewViewport], to shift overlap in a [NestedScrollView].
///
/// A particular [SliverOverlapAbsorberHandle] can only be assigned to a single
/// [SliverOverlapAbsorber] at a time. It can also be (and normally is) assigned
/// to one or more [SliverOverlapInjector]s, which must be later descendants of
/// the same [NestedScrollViewViewport] as the [SliverOverlapAbsorber]. The
/// [SliverOverlapAbsorber] must be a direct descendant of the
/// [NestedScrollViewViewport], taking part in the same sliver layout. (The
/// [SliverOverlapInjector] can be a descendant that takes part in a nested
/// scroll view's sliver layout.)
///
/// Whenever the [NestedScrollViewViewport] is marked dirty for layout, it will
/// cause its assigned [SliverOverlapAbsorberHandle] to fire notifications. It
/// is the responsibility of the [SliverOverlapInjector]s (and any other
/// clients) to mark themselves dirty when this happens, in case the geometry
/// subsequently changes during layout.
///
/// See also:
///
///  * [NestedScrollView], which uses a [NestedScrollViewViewport] and a
///    [SliverOverlapAbsorber] to align its children, and which shows sample
///    usage for this class.
class SliverOverlapAbsorberHandle extends ChangeNotifier {
  /// Creates a [SliverOverlapAbsorberHandle].
  SliverOverlapAbsorberHandle() {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  // Incremented when a RenderSliverOverlapAbsorber takes ownership of this
  // object, decremented when it releases it. This allows us to find cases where
  // the same handle is being passed to two render objects.
  int _writers = 0;

  /// The current amount of overlap being absorbed by the
  /// [SliverOverlapAbsorber].
  ///
  /// This corresponds to the [SliverGeometry.layoutExtent] of the child of the
  /// [SliverOverlapAbsorber].
  ///
  /// This is updated during the layout of the [SliverOverlapAbsorber]. It
  /// should not change at any other time. No notifications are sent when it
  /// changes; clients (e.g. [SliverOverlapInjector]s) are responsible for
  /// marking themselves dirty whenever this object sends notifications, which
  /// happens any time the [SliverOverlapAbsorber] might subsequently change the
  /// value during that layout.
  double? get layoutExtent => _layoutExtent;
  double? _layoutExtent;

  /// The total scroll extent of the gap being absorbed by the
  /// [SliverOverlapAbsorber].
  ///
  /// This corresponds to the [SliverGeometry.scrollExtent] of the child of the
  /// [SliverOverlapAbsorber].
  ///
  /// This is updated during the layout of the [SliverOverlapAbsorber]. It
  /// should not change at any other time. No notifications are sent when it
  /// changes; clients (e.g. [SliverOverlapInjector]s) are responsible for
  /// marking themselves dirty whenever this object sends notifications, which
  /// happens any time the [SliverOverlapAbsorber] might subsequently change the
  /// value during that layout.
  double? get scrollExtent => _scrollExtent;
  double? _scrollExtent;

  void _setExtents(double? layoutValue, double? scrollValue) {
    debugPrint(
        'fdeg _setExtents layoutValue:$layoutValue, scrollValue:$scrollValue');
    assert(
      _writers == 1,
      'Multiple RenderSliverOverlapAbsorbers have been provided the same SliverOverlapAbsorberHandle.',
    );
    _layoutExtent = layoutValue;
    _scrollExtent = scrollValue;
  }

  void _markNeedsLayout() => notifyListeners();

  @override
  String toString() {
    String? extra;
    switch (_writers) {
      case 0:
        extra = ', orphan';
      case 1:
        // normal case
        break;
      default:
        extra = ', $_writers WRITERS ASSIGNED';
        break;
    }
    return '${objectRuntimeType(this, 'SliverOverlapAbsorberHandle')}($layoutExtent$extra)';
  }
}

/// A sliver that wraps another, forcing its layout extent to be treated as
/// overlap.
///
/// The difference between the overlap requested by the child `sliver` and the
/// overlap reported by this widget, called the _absorbed overlap_, is reported
/// to the [SliverOverlapAbsorberHandle], which is typically passed to a
/// [RenderSliverOverlapInjector].
class RenderSliverOverlapAbsorber extends RenderSliver
    with RenderObjectWithChildMixin<RenderSliver> {
  /// Create a sliver that absorbs overlap and reports it to a
  /// [SliverOverlapAbsorberHandle].
  ///
  /// The [sliver] must be a [RenderSliver].
  RenderSliverOverlapAbsorber({
    required SliverOverlapAbsorberHandle handle,
    RenderSliver? sliver,
  }) : _handle = handle {
    child = sliver;
  }

  /// The object in which the absorbed overlap is recorded.
  ///
  /// A particular [SliverOverlapAbsorberHandle] can only be assigned to a
  /// single [RenderSliverOverlapAbsorber] at a time.
  SliverOverlapAbsorberHandle get handle => _handle;
  SliverOverlapAbsorberHandle _handle;
  set handle(SliverOverlapAbsorberHandle value) {
    if (handle == value) {
      return;
    }
    if (attached) {
      handle._writers -= 1;
      value._writers += 1;
      value._setExtents(handle.layoutExtent, handle.scrollExtent);
    }
    _handle = value;
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    handle._writers += 1;
  }

  @override
  void detach() {
    handle._writers -= 1;
    super.detach();
  }

  @override
  void performLayout() {
    assert(
      handle._writers == 1,
      'A SliverOverlapAbsorberHandle cannot be passed to multiple RenderSliverOverlapAbsorber objects at the same time.',
    );
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    child!.layout(constraints, parentUsesSize: true);
    final SliverGeometry childLayoutGeometry = child!.geometry!;
    geometry = childLayoutGeometry.copyWith(
      paintOrigin: 100,
      scrollExtent: childLayoutGeometry.scrollExtent -
          childLayoutGeometry.maxScrollObstructionExtent,
      layoutExtent: max(
          0,
          childLayoutGeometry.paintExtent -
              childLayoutGeometry.maxScrollObstructionExtent),
    );

    debugPrint(
        'fdeg RenderSliverOverlapAbsorber performLayout geometry:${geometry?.paintOrigin}, constraints:$constraints');
    handle._setExtents(
      childLayoutGeometry.maxScrollObstructionExtent,
      childLayoutGeometry.maxScrollObstructionExtent,
    );
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    // child is always at our origin
  }

  @override
  bool hitTestChildren(SliverHitTestResult result,
      {required double mainAxisPosition, required double crossAxisPosition}) {
    if (child != null) {
      return child!.hitTest(
        result,
        mainAxisPosition: mainAxisPosition,
        crossAxisPosition: crossAxisPosition,
      );
    }
    return false;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<SliverOverlapAbsorberHandle>('handle', handle));
  }
}
