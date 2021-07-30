import 'package:flutter/material.dart';
import 'package:flutter_app_02/config/color.dart';
import 'package:flutter_app_02/config/string.dart';

enum ViewState{
  LOADING,DONE,ERROR
}

class LoadingStateWidget extends StatelessWidget {
  final ViewState? loadingState;
  final VoidCallback? retry;
  final Widget child;

  LoadingStateWidget({Key? key, this.loadingState, this.retry, required this.child}) : super(key:key);


  @override
  Widget build(BuildContext context) {
    if(loadingState == ViewState.LOADING){
      debugPrint("状态: _loadWidget");
      return _loadWidget;
    }else if(loadingState == ViewState.ERROR){
      debugPrint("状态: _errorWidget");
      return _errorWidget;
    }else {
      debugPrint("状态: child");
      return child;
    }
  }

  Widget get _loadWidget {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget get _errorWidget {
    return Center(
      // 类似LinearLayout
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/ic_error.png',
            width: 100,
            height: 100,
          ),
          const Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              StringConfig.net_request_fail,
              style: TextStyle(color: ColorConfig.hitTextColor, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: OutlinedButton(
              onPressed: retry,
              child: const Text(
                StringConfig.reload_again,
                style: TextStyle(color: Colors.black87),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.black12)),
            ),
          )
        ],
      ),
    );
  }
}
