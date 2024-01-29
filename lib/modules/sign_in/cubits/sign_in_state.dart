abstract class SignInState {}

class InitSignInState extends SignInState {}

class LoadingSignInState extends SignInState {}

class ErrorSignInState extends SignInState {
  final String message;
  ErrorSignInState(this.message);
}

class SuccessfulSignInState extends SignInState {}