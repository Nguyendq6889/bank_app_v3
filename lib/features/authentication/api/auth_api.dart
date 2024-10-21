import 'package:bank_app_v3/modules/sign_in/model/response_sign_in_model.dart';
import 'package:dio/dio.dart';

class AuthApi {
  final Dio dio;
  AuthApi(this.dio);

  Future<ResponseSignInModel> signIn(String username, String password) async {
    try {
      final response = await dio.post(
        // 'https://dummyjson.com/user/login',
        'https://dummyjson.com/auth/login',
        data: {
          "username": username,
          "password": password,
        },
      );
      return ResponseSignInModel.fromJson(response.data);
    } on DioException catch (e) {
      // Server trả về statusCode nằm ngoài phạm vi 2xx và cũng không phải là 304.
      if (e.response != null) {
        throw Exception('\nSTATUS_CODE: ${e.response!.statusCode} \nDATA: ${e.response!.data}');
      } else {
        // Lỗi trong khi gọi lên server, ví dụ do mất internet.
        throw Exception(e.message);
      }
    }
  }
}
