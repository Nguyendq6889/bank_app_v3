import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'https://jsonplaceholder.typicode.com/',
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
  // sendTimeout: const Duration(seconds: 5),
));

class DioConfig {
  DioConfig() {
    // dio.interceptors.add(QueuedInterceptorsWrapper(
    //   onRequest: (options, handler) async {
    //     final sharedPref = await SharedPreferencesService.instance;
    //     final String _token = sharedPref.tokenGateway ?? '';
    //     // Thêm access token vào header
    //     options.headers['Authorization'] = 'Bearer $_token';
    //     return handler.next(options);
    //   },
    //   onError: (DioError e, handler) async {
    //     if (e.response?.statusCode == 401) {
    //       // Nếu statusCode trả về là 401 thì gọi hàm refreshTokenGateway()
    //       String? newAccessToken = await refreshTokenGateway();
    //       // Cập nhật the request header với access token mới
    //       e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
    //       // Tiếp tục gọi các API khác với header mới
    //       return handler.resolve(await _dio.fetch(e.requestOptions));
    //     }
    //     return handler.next(e);
    //   },
    // ));
  }

  Future<T> get<T>(String url, String token, Function(Map<String, dynamic>) fromJson) async {
    if (kDebugMode) {     // just using it in debug mode.
      dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));      // add the interceptor.
    }
    try {
      final response = await dio.get(
        url,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      final data = fromJson(response.data);
      return data as T;
    } on DioException catch (e) {
      // Server trả về statusCode nằm ngoài phạm vi 2xx và cũng không phải là 304.
      if (e.response != null) {
        throw Exception('STATUS_CODE: ${e.response!.statusCode} \n DATA: ${e.response!.data}');
      } else {
        // Lỗi trong khi gọi lên server, ví dụ do mất internet.
        throw Exception(e.message);
      }
    }
  }

  Future<T> post<T>(String url, String token, dynamic dataRequest, Function(Map<String, dynamic>) fromJson) async {
    if (kDebugMode) {     // just using it in debug mode.
      dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));      // add the interceptor.
    }
    try {
      final response = await dio.post(
        url,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: dataRequest,
      );
      final data = fromJson(response.data);
      return data as T;
    } on DioException catch (e) {
      // Server trả về statusCode nằm ngoài phạm vi 2xx và cũng không phải là 304.
      if (e.response != null) {
        throw Exception('STATUS_CODE: ${e.response!.statusCode} \n DATA: ${e.response!.data}');
      } else {
        // Lỗi trong khi gọi lên server, ví dụ do mất internet.
        throw Exception(e.message);
      }
    }
  }
}
