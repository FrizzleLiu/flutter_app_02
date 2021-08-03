import 'package:flutter/material.dart';
import 'package:flutter_app_02/http/http_manager.dart';
import 'package:flutter_app_02/http/url.dart';
import 'package:flutter_app_02/model/common_item.dart';
import 'package:flutter_app_02/model/issue_model.dart';
import 'package:flutter_app_02/ui/widget/loading_state_widget.dart';
import 'package:flutter_app_02/util/Toast.dart';
import 'package:flutter_app_02/viewmodel/base_change_notifyer.dart';
import 'package:flutter_app_02/viewmodel/base_list_viewmodel.dart';

class HomePageViewmodel extends BaseListViewModel<Item,IssueEntity> {
  List<Item>? bannerList = [];


  @override
  void getData(List<Item> list) {
    bannerList = list;
    itemList.clear();
    //为Banner占位,后面接ListView
    itemList.add(Item());
  }

  @override
  void removeUseLessData(List<Item> list) {
    list.removeWhere((element) => element.type == 'banner2');
  }

  @override
  IssueEntity getModel(Map<String, dynamic> json) {
    return IssueEntity.fromJson(json);
  }

  @override
  String getUrl() {
    return Api.feedUrl;
  }

  @override
  void doExtraAfterRefresh() async{
    await loadMore();
  }
}
