import 'package:flutter/material.dart';
import 'package:flutter_app_02/ui/page/home/home_page.dart';
import 'package:flutter_app_02/ui/widget/home/banner_widget.dart';
import 'package:flutter_app_02/ui/widget/loading_state_widget.dart';
import 'package:flutter_app_02/ui/widget/provider_widget.dart';
import 'package:flutter_app_02/viewmodel/home/home_page_viewmodel.dart';

class HomeBodyPage extends StatefulWidget {
  @override
  _HomeBodyPageState createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<HomePageViewmodel>(
        model: HomePageViewmodel(),
        onModelInit: (model) => model.refresh(),
        builder: (contex, model, child) {
          return LoadingStateWidget(
              child: _banner(model),
              loadingState: model.viewState,
              retry: model.retry);
        });
  }

  ///Banner
  _banner(model){
    return Container(
      height: 200,
      padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
      // ClipRRect:对子组件进行圆角裁剪
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BannerWidget(model: model),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
