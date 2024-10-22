import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/authentication/api/auth_api.dart';
import '../features/authentication/repository/auth_repo.dart';
import '../utils/local_data.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'https://dummyjson.com/',
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
  // sendTimeout: const Duration(seconds: 5),
))..interceptors.add(PrettyDioLogger(responseBody: false))
..interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));

class DioConfig {
  DioConfig() {
    dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        final SharedPreferences sharedPre = await SharedPreferences.getInstance();    // Retrieve an instance of SharedPreferences.
        final String? token = LocalData(sharedPre).getToken();
        // Thêm access token vào header
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Nếu statusCode trả về là 401 thì gọi hàm refreshToken()
          final SharedPreferences sharedPre = await SharedPreferences.getInstance();    // Retrieve an instance of SharedPreferences.
          final String? newAccessToken = await AuthRepo(AuthApi(dio), LocalData(sharedPre)).refreshToken();
          // Cập nhật request header với access token mới
          e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          // Tiếp tục gọi các API khác với header mới
          return handler.resolve(await dio.fetch(e.requestOptions));
        }
        return handler.next(e);
      },
    ));
  }

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
