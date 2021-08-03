import 'package:flutter/material.dart';
import 'package:flutter_app_02/model/common_item.dart';
import 'package:flutter_app_02/util/navigator_util.dart';

const VIDEO_SMALL_CARD_TYPE = 'videoSmallCard';

class VideoDetailPage extends StatefulWidget {

  ///路径: common_item包
  Data? videoData;

  VideoDetailPage(this.videoData,{Key? key}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> with WidgetsBindingObserver{
  ///允许element在树周围移动(改变父节点),而不丢失状态
  // final GlobalKey<VideoPalyWidgetState> videoKey = GlobalKey();
  Data? data;

  @override
  void initState() {
    super.initState();
    ///路由传过来的数据
    data = widget.videoData ?? arguments();
    WidgetsBinding.instance?.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ///AppLifecycleState当前页面状态(是否可见)
    // if(state == AppLifecycleState.paused){
    //   videoKey.currentState.pause();
    // }else if(state == AppLifecycleState.resumed){
    //   videoKey.currentState.play();
    // }
  }

  @override
  void dispose() {
    ///移除界面可见不可见的监听
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
