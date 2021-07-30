import 'package:flutter/material.dart';
import 'package:flutter_app_02/http/http_manager.dart';
import 'package:flutter_app_02/http/url.dart';
import 'package:flutter_app_02/model/common_item.dart';
import 'package:flutter_app_02/model/issue_model.dart';
import 'package:flutter_app_02/ui/widget/loading_state_widget.dart';
import 'package:flutter_app_02/util/Toast.dart';
import 'package:flutter_app_02/viewmodel/base_change_notifyer.dart';

class HomePageViewmodel extends BaseChangeNotifyer {
  List<Item>? bannerList = [];

  void refresh() async {
    HttpManager.getData(Api.feedUrl, success: (json) {
      var model = IssueEntity.fromJson(json);
      bannerList = model.itemList;
      //移除类型为banner2的数据
      bannerList?.removeWhere((element) => element.type == 'banner2');
      debugPrint("bannerList length: ${bannerList?.length}");
      viewState = ViewState.DONE;
    }, fail: (e) {
      viewState = ViewState.ERROR;
      ToastUtil.showToast(e.toString());
      debugPrint("失败失败 ${e.toString()}");
    }, complete: () {
      notifyListeners();
    });
  }

  ///错误重试
  retry() {
    viewState = ViewState.LOADING;
    notifyListeners();
  }
}
