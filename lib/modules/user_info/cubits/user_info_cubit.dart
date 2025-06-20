import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/user_info_repo.dart';
import 'user_info_state.dart';


class UserInfoCubit extends Cubit<UserInfoState> {
  final UserInfoRepo _userInfoRepo;
  UserInfoCubit(this._userInfoRepo) : super(InitUserInfoState());

  Future<void> getUserInfo() async {
    emit(LoadingUserInfoState());
    try {
      final response = await _userInfoRepo.getUserInfo();
      await Future.delayed(const Duration(seconds: 1));
      if(response != null) {
        emit(SuccessfulUserInfoState(response));
      } else {
        emit(ErrorUserInfoState('Đã có lỗi xảy ra. Vui lòng thử lại sau!'));
      }
    } catch(error, stackTrace) {
      // if (kDebugMode) {
      //   print(error);
      //   print(stackTrace);
      // }
      emit(ErrorUserInfoState(error.toString()));
      rethrow;      // it also prints out the error and stackTrace, help make debugging easier.
    }
  }
}
