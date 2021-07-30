import 'package:flutter/material.dart';
import 'package:flutter_app_02/config/string.dart';
import 'package:flutter_app_02/ui/page/home/home_body_page.dart';
import 'package:flutter_app_02/ui/widget/app_bar.dart';
import 'package:flutter_app_02/ui/widget/loading_state_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: appBar(StringConfig.home, showBack: false),
      body: HomeBodyPage(),
    );
  }

  ///保持页面存活,Page切换不重建当前Page
  ///注意:使用AutomaticKeepAliveClientMixin必须在build方法中调用super.build(context);
  @override
  bool get wantKeepAlive => true;
}
