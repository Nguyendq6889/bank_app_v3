part of 'auth_cubit.dart';

class AuthState {}

class AuthInitialState extends AuthState {}

class InProgressSignInState extends AuthState {}

class FailureSignInState extends AuthState {
  final String message;
  FailureSignInState({required this.message});
}

class SuccessfulSignInState extends AuthState {}

class AuthenticatedState extends AuthState {}

class UnAuthenticatedState extends AuthState {}
