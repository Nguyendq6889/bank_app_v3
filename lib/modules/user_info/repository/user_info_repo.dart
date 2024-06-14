import '../../../config/dio_config.dart';
import '../models/user_info_model.dart';

class UserInfoRepo {
  final dioConfig = DioConfig();

  Future<UserInfoModel?> getUserInfo() async {
    const String url = 'users/1';
    return await dioConfig.request<UserInfoModel>(
      url: url,
      method: 'GET',
      fromJson: (data) => UserInfoModel.fromJson(data),
    );
  }
}
