import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

//插件的bannner指示器位置有问题,自定义控件解决指示器摆放位置的问题
class CustomerSwiperPagination extends SwiperPagination {

  /// Alignment.bottomCenter by default when scrollDirection== Axis.horizontal
  /// Alignment.centerRight by default when scrollDirection== Axis.vertical
  final Alignment alignment;

  /// Distance between pagination and the container
  final EdgeInsetsGeometry margin;

  /// Build the widget
  final SwiperPlugin builder;

  final Key? key;

  const CustomerSwiperPagination({
    this.alignment = Alignment.bottomRight,
    this.key,
    this.margin = const EdgeInsets.all(10.0),
    this.builder = SwiperPagination.dots,
  });

  @override
  Widget build(BuildContext context, SwiperPluginConfig? config) {
    Widget child = Container(
      margin: margin,
      child: builder.build(context, config!),
    );
    if (!config.outer!) {
      child = Align(
        key: key,
        alignment: alignment,
        child: child,
      );
    }
    return child;
  }
}
