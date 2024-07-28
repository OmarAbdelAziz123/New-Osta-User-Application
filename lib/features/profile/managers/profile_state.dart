part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitialState extends ProfileState {}

/// Get All Profile Data States
class GetProfileDataLoadingState extends ProfileState {}

class GetProfileDataSuccessState extends ProfileState {}

class GetProfileDataErrorState extends ProfileState {}

/// Update Profile Data States
class UpdateProfileDataLoadingState extends ProfileState {}

class UpdateProfileDataSuccessState extends ProfileState {}

class UpdateProfileDataErrorState extends ProfileState {}

/// Get All Faqs States
class GetAllFaqsCategoryLoadingState extends ProfileState {}

class GetAllFaqsCategorySuccessState extends ProfileState {
  final List<Result>? resultList;

  GetAllFaqsCategorySuccessState({this.resultList});
}

class GetAllFaqsCategoryErrorState extends ProfileState {}

/// Get All Faqs Index States
class GetAllFaqsCategoryIndexLoadingState extends ProfileState {}

class GetAllFaqsCategoryIndexSuccessState extends ProfileState {}

class GetAllFaqsCategoryIndexErrorState extends ProfileState {}

/// Make Messages States
class MakeMessagesLoadingState extends ProfileState {}

class MakeMessagesSuccessState extends ProfileState {}

class MakeMessagesErrorState extends ProfileState {}

/// Get Tickets States
class GetTicketsLoadingState extends ProfileState {}

class GetTicketsSuccessState extends ProfileState {}

class GetTicketsErrorState extends ProfileState {}