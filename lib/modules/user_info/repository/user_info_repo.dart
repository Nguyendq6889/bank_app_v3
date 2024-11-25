import '../../../config/dio_config.dart';
import '../../../utils/api_config.dart';
import '../models/user_info_model.dart';

class UserInfoRepo {
  // final dioConfig = DioConfig();
  final ApiConfig _api = ApiConfig();

  Future<UserInfoModel?> getUserInfo() async {
    const String url = 'auth/me';
    return await _api.request<UserInfoModel>(
      url: url,
      method: 'GET',
      fromJson: (data) => UserInfoModel.fromJson(data),
    );
  }
}
