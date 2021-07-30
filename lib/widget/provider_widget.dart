import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///借助Provider库实现App的状态管理
///T 是Model 集成自 ChangeNotifier 数据改变有通知UI刷新的功能
class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;

  ///维护数据
  final Widget? child;
  final Function(T)? onModelInit;

  ///网络请求数据方法(初始化model的方法)
  ///提供一个builder
  final Widget Function(
    BuildContext contex,
    T model,
    Widget? child,
  ) builder;

  ProviderWidget(
      {Key? key,
      required this.model,
      this.child,
      this.onModelInit,
      required this.builder})
      : super(key: key);

  @override
  _ProviderWidgetState createState() => _ProviderWidgetState();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  late T model;

  @override
  void initState() {
    super.initState();
    model = widget.model;

    ///初始化model
    widget.onModelInit?.call(model);
  }

  @override
  Widget build(BuildContext context) {
    ///Consumer 一般配合 ChangeNotifierProvider使用
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Consumer(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
