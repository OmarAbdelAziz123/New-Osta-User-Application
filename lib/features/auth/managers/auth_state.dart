part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

/// Login States
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final String? message;

  LoginSuccessState({this.message});
}

class LoginErrorState extends AuthState {}

/// Verify OTP States
class VerifyOTPLoadingState extends AuthState {}

class VerifyOTPSuccessState extends AuthState {
  final String message;

  VerifyOTPSuccessState(this.message);
}

class VerifyOTPErrorState extends AuthState {}

class VerifyOTPErrorStateWithMessage extends AuthState {
  final String message;

  VerifyOTPErrorStateWithMessage(this.message);
}

/// Fill Your Account States
class FillYourAccountLoadingState extends AuthState {}

class FillYourAccountSuccessState extends AuthState {
  final String? message;

  FillYourAccountSuccessState({this.message});
}

class FillYourAccountErrorState extends AuthState {
  final String? message;

  FillYourAccountErrorState(this.message);
}

/// Country Index
class CountryIndexLoadingState extends AuthState {}

class CountryIndexSuccessState extends AuthState {}

class CountryIndexErrorState extends AuthState {}
