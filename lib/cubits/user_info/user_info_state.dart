import '../../models/user_info/user_info_model.dart';

abstract class UserInfoState {}

class InitUserInfoState extends UserInfoState {}

class LoadingUserInfoState extends UserInfoState {}

class ErrorUserInfoState extends UserInfoState {
  final String message;
  ErrorUserInfoState(this.message);
}

class SuccessfulUserInfoState extends UserInfoState {
  final UserInfoModel userInfo;
  SuccessfulUserInfoState(this.userInfo);
}
