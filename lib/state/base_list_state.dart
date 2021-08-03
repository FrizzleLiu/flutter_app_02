import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_02/model/paging_model.dart';
import 'package:flutter_app_02/ui/widget/loading_state_widget.dart';
import 'package:flutter_app_02/ui/widget/provider_widget.dart';
import 'package:flutter_app_02/viewmodel/base_list_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListState<L, M extends BaseListViewModel<L, PagingModel<L>>,
        T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  M get viewModel; //真实的获取数据类型
  Widget getContentChild(M model);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<M>(
        model: viewModel,
        onModelInit: (model) => model.refresh(),
        builder: (context, model, child) {
          return LoadingStateWidget(
              viewState: model.viewState,
              child: Container(
                color: Colors.white,
                child: SmartRefresher(
                  controller: model.refreshController,
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  enablePullUp: true,
                  child: getContentChild(model),
                ),
              ));
        });
  }

  @override
  bool get wantKeepAlive => true;
}
