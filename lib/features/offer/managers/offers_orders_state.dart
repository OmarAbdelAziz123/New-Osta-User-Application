part of 'offers_orders_cubit.dart';

@immutable
abstract class OffersOrdersState {}

class OffersOrdersInitialState extends OffersOrdersState {}

/// Get All Orders States
class GetAllOrdersLoadingState extends OffersOrdersState {}

class GetAllOrdersSuccessState extends OffersOrdersState {}

class GetAllOrdersErrorState extends OffersOrdersState {}

/// Get All Offers
class GetAllOffersLoadingState extends OffersOrdersState {}

class GetAllOffersSuccessState extends OffersOrdersState {}

class GetAllOffersErrorState extends OffersOrdersState {}

/// Accept Offers
class AcceptOffersLoadingState extends OffersOrdersState {}

class AcceptOffersSuccessState extends OffersOrdersState {}

class AcceptOffersErrorState extends OffersOrdersState {}

/// Reject Offers
class RejectOffersLoadingState extends OffersOrdersState {}

class RejectOffersSuccessState extends OffersOrdersState {}

class RejectOffersErrorState extends OffersOrdersState {}
