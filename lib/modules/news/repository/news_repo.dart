import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/news_model.dart';

class NewsRepo {
  final _dio = Dio();

  Future<ListNewsModel> getListNews(int page) async {
    String url = 'https://jsonplaceholder.typicode.com/users/$page/posts';
    if (kDebugMode) {     // just using it in debug mode.
      _dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));      // add the interceptor.
    }
    final response = await _dio.get(url);
    if(response.statusCode == 200){
      Map<String, dynamic> data = {"listNews": response.data};
      final data2 = ListNewsModel.fromJson(data);
      return data2;
    } else {
      throw 'Something went wrong code ${response.statusCode}';
    }
  }
}
