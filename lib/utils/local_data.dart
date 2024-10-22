import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  final SharedPreferences sharedPre;
  LocalData(this.sharedPre);

  Future<void> saveToken(String token) async {
    await sharedPre.setString('token', token);
  }

  String? getToken() {
    return sharedPre.getString('token');
  }

  Future<bool> deleteToken() async {
    return await sharedPre.remove('token');
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await sharedPre.setString('refreshToken', refreshToken);
  }

  String? getRefreshToken() {
    return sharedPre.getString('refreshToken');
  }

  Future<bool> deleteRefreshToken() async {
    return await sharedPre.remove('refreshToken');
  }
}
