import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitialState());

  Future<void> signIn({required String username, required String password}) async {
    emit(InProgressSignInState());
    try {
      final result = await _authRepo.signIn(username, password);
      if(result) {
        emit(SuccessfulSignInState());
      } else {
        emit(FailureSignInState(message: 'Đăng nhập không thành công. Vui lòng thử lại sau!'));
      }
    } catch(error) {
      emit(FailureSignInState(message: 'Đăng nhập không thành công. Vui lòng thử lại sau!'));
      rethrow;      // it also prints out the error and stackTrace, help make debugging easier.
    }
  }

  void authentication() {
    try {
      final result = _authRepo.getToken();
      // print(result);
      if (result) {
        emit(AuthenticatedState());
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (error){
      emit(UnAuthenticatedState());
      rethrow;      // it also prints out the error and stackTrace, help make debugging easier.
    }
  }

  Future<void> signOut() async {
    try {
      final result = await _authRepo.signOut();
      // print(result);
      if (result) {
        emit(UnAuthenticatedState());
      } else {
        emit(AuthenticatedState());
      }
    } catch (error){
      emit(AuthenticatedState());
      rethrow;      // it also prints out the error and stackTrace, help make debugging easier.
    }
  }
}
