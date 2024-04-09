part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

/// Login States
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {}

/// Verify OTP States
class VerifyOTPLoadingState extends AuthState {}

class VerifyOTPSuccessState extends AuthState {}

class VerifyOTPErrorState extends AuthState {}

/// Fill Your Account States
class FillYourAccountLoadingState extends AuthState {}

class FillYourAccountSuccessState extends AuthState {}

class FillYourAccountErrorState extends AuthState {}

/// Country Index
class CountryIndexLoadingState extends AuthState {}

class CountryIndexSuccessState extends AuthState {}

class CountryIndexErrorState extends AuthState {}
