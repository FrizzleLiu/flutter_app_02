import 'package:flutter/cupertino.dart';
import 'package:flutter_app_02/http/http_manager.dart';
import 'package:flutter_app_02/model/paging_model.dart';
import 'package:flutter_app_02/ui/widget/loading_state_widget.dart';
import 'package:flutter_app_02/util/Toast.dart';
import 'package:flutter_app_02/viewmodel/base_change_notifyer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListViewModel<T, M extends PagingModel<T>>
    extends BaseChangeNotifyer {
  //集合数组
  List<T> itemList = [];

  String? nextPageUrl;

  //请求数据地址
  String getUrl();

  //请求返回的真实数据模型
  M getModel(Map<String, dynamic> json);

  //下拉刷新上拉加载控制器
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  //获取数据
  void getData(List<T> list) {
    itemList = list;
  }

  //移除无用数据
  void removeUseLessData(List<T> list) {}

  //下拉刷新后的额外操作
  void doExtraAfterRefresh() {}

  //上拉加载更多请求地址
  String? getNextUrl(M model) {
    return model.nextPageUrl;
  }

  //下拉刷新
  void refresh() {
    HttpManager.getData(getUrl(), success: (json) {
      M model = getModel(json);
      removeUseLessData(model.itemList);
      getData(model.itemList);
      viewState = ViewState.DONE;

      ///首页数据banner和列表是同一个接口获取,第一页数据用作banner,第二页数据用作list
      nextPageUrl = getNextUrl(model);
      refreshController.refreshCompleted();
      refreshController.footerMode?.value = LoadStatus.canLoading;
      doExtraAfterRefresh();
    }, fail: (e) {
      ToastUtil.showToast(e.toString());
      refreshController.refreshFailed();
      viewState = ViewState.ERROR;
    }, complete: () {
      notifyListeners();
    });
  }

  //加载更多
  Future<void> loadMore() async {
    debugPrint("执行loadMore ${nextPageUrl}");
    if (nextPageUrl == null || nextPageUrl!.isEmpty) {
      refreshController.loadNoData();
      return;
    }
    HttpManager.getData(nextPageUrl!, success: (json) {
      debugPrint("执行loadMore成功");
      M model = getModel(json);
      removeUseLessData(model.itemList);
      itemList.addAll(model.itemList);
      nextPageUrl = getNextUrl(model);
      refreshController.refreshCompleted();
      notifyListeners();
    }, fail: (e) {
      debugPrint("执行loadMore失败");
      ToastUtil.showToast(e.toString());
      refreshController.loadFailed();
    });
  }

  //错误重试
  retry() {
    viewState = ViewState.LOADING;
    notifyListeners();
    refresh();
  }
}
