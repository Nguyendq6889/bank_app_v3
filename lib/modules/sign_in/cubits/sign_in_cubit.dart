import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/sign_in_repo.dart';
import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInRepo _signInRepo;
  SignInCubit(this._signInRepo) : super(InitSignInState());
}
