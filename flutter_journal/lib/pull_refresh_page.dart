import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_journal/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'wave_refresh_header.dart';

class PullRefreshPage extends StatefulWidget {
  static String routeName = 'PullRefreshPage';

  const PullRefreshPage({super.key});

  @override
  State<PullRefreshPage> createState() => _PullRefreshPageState();
}

class _PullRefreshPageState extends State<PullRefreshPage> {
  final EasyRefreshController _refreshController = EasyRefreshController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: EasyRefresh(
        onRefresh: _onRefresh,
        onLoad: _loadMore,
        controller: _refreshController,
        scrollController: _controller,
        header: WaveHeader(waveColor: Colors.blue, textColor: Colors.blue),
        topBouncing: false,
        // firstRefresh: true,
        enableControlFinishLoad: true,
        enableControlFinishRefresh: true,
        headerIndex: 1,
        child: CustomScrollView(
          controller: _controller,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          slivers: <Widget>[
            const SliverAppBar(),
            SliverToBoxAdapter(
              child: ElevatedButton(onPressed: () {
                _refreshController.callRefresh();
              }, child: const Text('call refresh'),

              ),
            ),
            // _buildMiddleContainer(vm),
            SliverToBoxAdapter(
              child: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
                  return Container(
                    width: 1.sw,
                    height: 2.sh,
                    color: Colors.amber,
                  );
                },
              ),
            ),
            // SliverToBoxAdapter(
            //   child: BlurImage(
            //     scrollController: _controller,
            //     child: _buildMiddleContainer(vm),
            //   ),
            // ),
          ],
        ),
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

  /*
  *  初始化
  */
}
