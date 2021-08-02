
import 'package:flutter/material.dart';
import 'package:flutter_app_02/ui/widget/loading_state_widget.dart';

class BaseChangeNotifyer extends ChangeNotifier {
  ViewState viewState = ViewState.LOADING;
  bool _isDispose = false;

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
}
