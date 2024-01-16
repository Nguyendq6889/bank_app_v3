import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/user_info/user_info_model.dart';

class UserInfoRepo {
  final _dio = Dio();

  Future<UserInfoModel> getUserInfo() async {
    const String url = 'https://jsonplaceholder.typicode.com/users/1';
    if (kDebugMode) {     // just using it in debug mode.
      _dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));      // add the interceptor.
    }
    final response = await _dio.get(url);
    if(response.statusCode == 200){
      final data = UserInfoModel.fromJson(response.data);
      return data;
    } else {
      throw 'Something went wrong code ${response.statusCode}';
    }
  }
}
