import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpManager {
  static Utf8Decoder utf8decoder = Utf8Decoder();

  static void getData(String url,
      {Map<String, String>? headers,
      required Function success,
      Function? fail,
      Function? complete}) async {
    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        // 解析 json 字符串，返回的是 Map<String, dynamic> 类型
        // debugPrint("原始reponse数据${response.body.toString()}");
        var result = json.decode(utf8decoder.convert(response.bodyBytes));
        success(result);
        ///解析后的数据
        debugPrint("解析后的数据: ${result.toString()}");
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      debugPrint("网络请求发生异常: ${e.toString()}");
      fail?.call(e);
    } finally {
      if (complete != null) {
        complete();
      }
    }
  }
}
