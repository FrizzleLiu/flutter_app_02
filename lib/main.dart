import 'package:flutter/material.dart';
import 'package:flutter_app_02/app_init.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_app_02/ui/tab_navigation.dart';

import 'config/string.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
  //Flutter沉浸式状态栏，Platform.isAndroid 判断是否是Android手机
  if (Platform.isAndroid) {
    // setSystemUIOverlayStyle:用来设置状态栏顶部和底部样式
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This ui.widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppInit.init(),
      builder: (BuildContext buildContext, AsyncSnapshot<void> snapshot) {
        debugPrint("snapshot.connectionState : ${snapshot.connectionState}");
        var widget = snapshot.connectionState == ConnectionState.done
            ? TabNavigation(
              )
            : const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
        return (BuildMaterialAppWidhet(child: widget));
      },
    );
  }
}

class BuildMaterialAppWidhet extends StatefulWidget {
  final Widget child;

  BuildMaterialAppWidhet({Key? key, required this.child}) : super(key: key);

  @override
  _BuildMaterialAppWidhetState createState() => _BuildMaterialAppWidhetState();
}

class _BuildMaterialAppWidhetState extends State<BuildMaterialAppWidhet> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: StringConfig.app_name,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => widget.child),
      ],
    );
  }
}
