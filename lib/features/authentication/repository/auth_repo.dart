import 'package:bank_app_v3/features/authentication/api/auth_api.dart';
import '../../../modules/sign_in/model/response_sign_in_model.dart';
import '../../../utils/local_data.dart';

class AuthRepo {
  final AuthApi authApi;
  final LocalData localData;
  AuthRepo(this.authApi, this.localData);

  Future<bool> signIn(String username, String password) async {
    final response = await authApi.signIn(username, password);
    if(response.token != null) {
      await localData.saveToken(response.token!);
      return true;
    }
    return false;
  }

  bool getToken() {
    final token = localData.getToken();
    if(token == null) {
      return false;
    }
    return true;
  }

  Future<bool> signOut() async {
    final isDeleteToken = await localData.deleteToken();
    return isDeleteToken;
  }
}
