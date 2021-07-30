import 'package:flutter_app_02/viewmodel/base_change_notifyer.dart';

class TabNavigationViewmodel extends BaseChangeNotifyer{
  int currentIdex = 0;
  changeBottomTabIndex(int index){
    currentIdex = index;
    notifyListeners();
  }
}