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
    if (kDebugMode) {     // just using it in debug mode.
      // dio.interceptors.add(DioLoggingInterceptor(level: Level.body, compact: false));
      dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));      // add the interceptor.
    }

    // dio.interceptors.add(QueuedInterceptorsWrapper(
    //   onRequest: (options, handler) async {
    //     final sharedPref = await SharedPreferencesService.instance;
    //     final String token = sharedPref.tokenGateway ?? '';
    //     // Thêm access token vào header
    //     options.headers['Authorization'] = 'Bearer $token';
    //     return handler.next(options);
    //   },
    //   onError: (DioException e, handler) async {
    //     if (e.response?.statusCode == 401) {
    //       // Nếu statusCode trả về là 401 thì gọi hàm refreshTokenGateway()
    //       String? newAccessToken = await refreshTokenGateway();
    //       // Cập nhật the request header với access token mới
    //       e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
    //       // Tiếp tục gọi các API khác với header mới
    //       return handler.resolve(await dio.fetch(e.requestOptions));
    //     }
    //     return handler.next(e);
    //   },
    // ));
  }

  // Future<String?> refreshTokenGateway() async {
  //   try {
  //     final sharedPref = await SharedPreferencesService.instance;
  //     final String token = sharedPref.tokenGateway ?? '';
  //     final String refreshToken = sharedPref.refreshTokenGateway ?? '';
  //     final String sessionCode = sharedPref.sessionCodeGateway ?? '';
  //
  //     const String url = 'api/auth/refreshtoken';
  //     final dataRequest = {
  //       "accessToken": token,
  //       "refreshToken": refreshToken,
  //       "sessionCode": sessionCode
  //     };
  //
  //     final response = await request<LoginResultModel>(
  //       url: url,
  //       method: 'POST',
  //       dataRequest: dataRequest,
  //       fromJson: (data) => LoginResultModel.fromJson(data),
  //     );
  //
  //     if (response.result != null && response.result!.data != null && response.result!.data!.token != null) {
  //       final String accessToken = response.result!.data!.token!;
  //       sharedPref.setTokenGateway(accessToken);
  //       sharedPref.setRefreshTokenGateway(response.result!.data!.refreshToken ?? '');
  //       sharedPref.setSessionCodeGateway(response.result!.data!.sessionCode ?? '');
  //       return accessToken;
  //     }
  //     return null;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<T> request<T>({
    required String url,
    required String method,
    dynamic dataRequest,
    required Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await dio.request(
        url,
        data: dataRequest,
        options: Options(method: method), // GET, POST, PUT, DELETE,...
      );
      // final response = await dio.post(
      //   url,
      //   // Nếu đã config ở hàm onRequest (chỗ dio.interceptors.add(QueuedInterceptorsWrapper()) rồi
      //   // thì không cần thiết phải config ở đây nữa.
      //   // options: Options(headers: {"Authorization": "Bearer $token"}),
      //   data: dataRequest,
      // );
      final data = fromJson(response.data);
      return data as T;
    } on DioException catch (e) {
      // Server trả về statusCode nằm ngoài phạm vi 2xx và cũng không phải là 304.
      if (e.response != null) {
        throw Exception('STATUS_CODE: ${e.response!.statusCode} \n DATA: ${e.response!.data}');
      } else {
        // Lỗi trong khi gọi lên server, ví dụ do mất internet hoặc connectTimeout.
        throw Exception(e.message);
      }
    }
  }
}
