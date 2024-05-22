part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

/// Services States
class AllServicesLoadingState extends HomeState {}

class AllServicesSuccessState extends HomeState {}

class AllServicesErrorState extends HomeState {}

/// Sub Services States
class SubServicesLoadingState extends HomeState {}

class SubServicesSuccessState extends HomeState {}

class SubServicesErrorState extends HomeState {}

// getSubServicesInIdThreeFunction

/// Sub Services In Three
class SubServicesInIdThreeLoadingState extends HomeState {}

class SubServicesInIdThreeSuccessState extends HomeState {}

class SubServicesInIdThreeErrorState extends HomeState {}

/// Make Order
class MakeOrderLoadingState extends HomeState {}

class MakeOrderSuccessState extends HomeState {}

class MakeOrderErrorState extends HomeState {}

/// Country Index
class CountryIndexLoadingState extends HomeState {}

class CountryIndexSuccessState extends HomeState {}

class CountryIndexErrorState extends HomeState {}

/// City Index
class CityIndexLoadingState extends HomeState {}

class CityIndexSuccessState extends HomeState {}

class CityIndexErrorState extends HomeState {}

/// Get All Addresses
class GetAllAddressesLoadingState extends HomeState {}

class GetAllAddressesSuccessState extends HomeState {}

class GetAllAddressesErrorState extends HomeState {}

/// Update All Addresses
class UpdateAddressesLoadingState extends HomeState {}

class UpdateAddressesSuccessState extends HomeState {}

class UpdateAddressesErrorState extends HomeState {}

/// Add Data For New Addresses States
class AddDataForNewAddressesLoadingState extends HomeState {}

class AddDataForNewAddressesSuccessState extends HomeState {}

class AddDataForNewAddressesErrorState extends HomeState {}