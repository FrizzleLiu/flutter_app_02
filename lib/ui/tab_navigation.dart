import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_02/config/string.dart';
import 'package:flutter_app_02/http/http_manager.dart';
import 'package:flutter_app_02/util/Toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  DateTime? _lastTime;
  Widget _curBody = Container(
    color: Colors.blue,
  );
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //防止误碰,双击退出app
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _curBody,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          ///文字固定
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          items: _buildBottomNavigationBarItems(),
          onTap: _onTap,
        ),
      ),
    );
  }

  ///导航栏items
  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    return [
      _buildItemStyle(StringConfig.home, "images/ic_home_normal.png", "images/ic_home_selected.png"),
      _buildItemStyle(StringConfig.discovery, "images/ic_discovery_normal.png", "images/ic_discovery_selected.png"),
      _buildItemStyle(StringConfig.hot, "images/ic_hot_normal.png", "images/ic_hot_selected.png"),
      _buildItemStyle(StringConfig.mine, "images/ic_mine_normal.png", "images/ic_mine_selected.png"),
    ];
  }

  ///导航栏item样式
  BottomNavigationBarItem _buildItemStyle(
      String label, String normalIcon, String selectedIcon) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          normalIcon,
          width: 24.0,
          height: 24.0,
        ),
        activeIcon: Image.asset(
          selectedIcon,
          width: 24.0,
          height: 24.0,
        ),
        label: label);
  }

  ///双击退出
  Future<bool> _onWillPop() async {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime!) > Duration(seconds: 2)) {
      _lastTime = DateTime.now();
      ToastUtil.showToast(StringConfig.exit_tip);
      return false;
    } else {
      return true;
    }
  }

  ///底部导航栏点击
  void _onTap(int index) {
    _currentIndex = index;
    switch (index){
      case 0:
        _curBody = Container(color: Colors.blue,);
        break;
      case 1:
        _curBody = Container(color: Colors.green,);
        break;
      case 2:
        _curBody = Container(color: Colors.red,);
        break;
      case 3:
        _curBody = Container(color: Colors.yellow,);
        break;
    }
    setState(() {});
  }
}
