import 'package:bank_app_v3/features/authentication/api/auth_api.dart';
import '../../../utils/local_data.dart';

class AuthRepo {
  final AuthApi authApi;
  final LocalData localData;
  AuthRepo(this.authApi, this.localData);

  Future<bool> signIn(String username, String password) async {
    final response = await authApi.signIn(username, password);
    if(response != null && response.accessToken != null) {
      await localData.saveToken(response.accessToken!);
      await localData.saveRefreshToken(response.refreshToken ?? '');
      return true;
    }
    return false;
  }

  Future<String?> refreshToken() async {
    final refreshToken = localData.getRefreshToken();
    final response = await authApi.refreshToken(refreshToken ?? '');
    if(response != null && response.accessToken != null) {
      await localData.saveToken(response.accessToken!);
      await localData.saveRefreshToken(response.refreshToken ?? '');
      return response.accessToken;
    }
    return null;
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
    final isDeleteRefreshToken = await localData.deleteRefreshToken();
    return isDeleteToken && isDeleteRefreshToken;
  }
}
