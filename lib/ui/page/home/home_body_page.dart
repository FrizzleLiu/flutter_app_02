import 'package:flutter/material.dart';
import 'package:flutter_app_02/model/common_item.dart';
import 'package:flutter_app_02/state/base_list_state.dart';
import 'package:flutter_app_02/ui/page/home/home_page.dart';
import 'package:flutter_app_02/ui/widget/home/banner_widget.dart';
import 'package:flutter_app_02/ui/widget/list_item_widget.dart';
import 'package:flutter_app_02/ui/widget/loading_state_widget.dart';
import 'package:flutter_app_02/ui/widget/provider_widget.dart';
import 'package:flutter_app_02/viewmodel/home/home_page_viewmodel.dart';

const TEXT_HEADER_TYPE = 'textHeader';

class HomeBodyPage extends StatefulWidget {
  @override
  _HomeBodyPageState createState() => _HomeBodyPageState();
  bool isShow = false;
}

class _HomeBodyPageState
    extends BaseListState<Item, HomePageViewmodel, HomeBodyPage> {
  @override
  Widget getContentChild(HomePageViewmodel model) {
    ///带有分割线的ListView
    debugPrint("model.itemList.length : ${model.itemList.length}");
    return ListView.separated(
        itemCount: model.itemList.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _banner(model);
          } else {
            if (model.itemList[index].type == TEXT_HEADER_TYPE) {
              return _titleItem(model.itemList[index]);
            }
            return ListItemWidget(item: model.itemList[index]);
          }
        },

        ///分隔线管理
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Divider(
                height: 0.5,
                    // model.itemList[index].type == TEXT_HEADER_TYPE || index == 0
                    //     ? 0
                    //     : 0.5,
                color: Color(0xffe6e6e6)),
                    // model.itemList[index].type == TEXT_HEADER_TYPE || index == 0
                    //     ? Colors.transparent
                    //     : Color(0xffe6e6e6)),
          );
        });
  }

  ///Banner
  _banner(model) {
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
  HomePageViewmodel get viewModel => HomePageViewmodel();

  Widget _titleItem(Item item) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white24),
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Center(
        child: Text(
          item.data?.text ?? "",
          style: const TextStyle(
              fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
