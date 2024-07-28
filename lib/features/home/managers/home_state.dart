part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

/// Set Location Value State
class SetValueState extends HomeState {
  final String? locationDec;

  SetValueState(this.locationDec);
}

/// Set Name Of Place Value State
class SetNameOfPlaceValueState extends HomeState {
  final String? nameOfPlace;

  SetNameOfPlaceValueState(this.nameOfPlace);
}

/// Make Store State
class MakeStoreValueState extends HomeState {
  final bool? makeStore;

  MakeStoreValueState(this.makeStore);
}

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

class MakeOrderSuccessState extends HomeState {
  final String? message;

  MakeOrderSuccessState(this.message);
}

class MakeOrderErrorState extends HomeState {
  final String? message;

  MakeOrderErrorState(this.message);
}

/// Store Location
class StoreOrUpdateLocationLoadingState extends HomeState {}

class StoreOrUpdateLocationSuccessState extends HomeState {}

class StoreOrUpdateLocationErrorState extends HomeState {}

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

/// Get All Offers States
class GetAllOffersLoadingState extends HomeState {}

class GetAllOffersSuccessState extends HomeState {}

class GetAllOffersErrorState extends HomeState {}
