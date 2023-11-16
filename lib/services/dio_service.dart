import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';

class DioHelper {
  Future<dynamic> getMethod(String url) async {
    Dio dio = Dio();
    return await dio
        .get(url,
            options: Options(responseType: ResponseType.json, method: 'GET'))
        .then((response) {
      return response.data;
    });
  }
}
