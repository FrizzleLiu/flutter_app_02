import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_02/model/common_item.dart';
import 'package:flutter_app_02/util/cache_image.dart';
import 'package:flutter_app_02/util/share_util.dart';

class ListItemWidget extends StatelessWidget {
  final Item item;
  final bool showCategory;
  final bool showDivider;

  const ListItemWidget(
      {Key? key,
      required this.item,
      this.showCategory = true,
      this.showDivider = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            ///TODO : 列表跳详情
            debugPrint("点击了列表项,跳转详情");
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Stack(
              children: [
                _clipRRectImage(context),
                _categoryText(context),
                _videoTime(),
              ],
            ),
          ),
        ),

        ///视频内容简介
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Row(
            children: [
              _authorHeaderImage(item),

              ///Expanded:具有权重属性的组件,可以控制Row,Colum,Flex的子控件如何布局的控件
              _videoDescription(),
              _shareButton(),
            ],
          ),
        )
      ],
    );
  }

  ///圆角图片
  _clipRRectImage(BuildContext context) {
    ///ClipRRect: 剪切圆角矩形
    return ClipRRect(
      ///Hero动画,界面跳转,关联动画
      child: Hero(
        tag: '${item.data?.id}${item.data?.time}',
        child: cacheImage(
          item.data?.cover?.feed ?? "",
          width: MediaQuery.of(context).size.width,
          height: 200,
        ),
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }

  ///图片左上角显示图标,视频所属分类
  _categoryText(BuildContext context) {
    ///用于定位Stack的子控件,Positioned必须是Stack的子控件
    return Positioned(
        left: 15,
        top: 10,
        //Opacity : 设置透明度,类似Android 中的invisible
        child: Opacity(
          opacity: showCategory ? 1.0 : 0.0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            height: 44,
            width: 44,
            alignment: AlignmentDirectional.center,
            child: Text(
              item.data?.category ?? "",
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ));
  }

  ///显示视频时长
  _videoTime() {
    return Positioned(
        right: 15,
        bottom: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: const BoxDecoration(color: Colors.black54),
            padding: const EdgeInsets.all(5),
            child: const Text(
              "视频时间",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  _authorHeaderImage(Item item) {
    return ClipOval(
      ///抗锯齿
      clipBehavior: Clip.antiAlias,
      child: cacheImage(item.data?.author?.icon ?? "", width: 48, height: 48),
    );
  }

  ///视频内容简介
  _videoDescription() {
    ///相当于Android中设置weight权重
    return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.data?.title ?? "",

                ///文本过长省略
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  item.data?.author?.name ?? "",
                  style:
                      const TextStyle(color: Color(0xff9a9a9a), fontSize: 12),
                ),
              ),
            ],
          ),
        ));
  }

  ///分享按钮
  _shareButton() {
    return IconButton(
        onPressed: () =>
            share(item.data?.title ?? "分享标题", item.data?.playUrl ?? ""),
        icon: const Icon(
          Icons.share,
          color: Colors.black38,
        ));
  }
}
