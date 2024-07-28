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

/// Inbox States
class InboxLoadingState extends OffersOrdersState {}

class InboxSuccessState extends OffersOrdersState {}

class InboxErrorState extends OffersOrdersState {
  final String message;

  InboxErrorState(this.message);
}

/// Get All Messages
class GetAllMessagesLoadingState extends OffersOrdersState {}

class GetAllMessagesSuccessState extends OffersOrdersState {}

class GetAllMessagesErrorState extends OffersOrdersState {}

/// Make Order is Done States
class MakeOrderIsDoneLoadingState extends OffersOrdersState {}

class MakeOrderIsDoneSuccessState extends OffersOrdersState {}

class MakeOrderIsDoneErrorState extends OffersOrdersState {
  final String message;

  MakeOrderIsDoneErrorState(this.message);
}

/// Make Action States
class MakeActionLoadingState extends OffersOrdersState {}

class MakeActionSuccessState extends OffersOrdersState {}

class MakeActionErrorState extends OffersOrdersState {
  final String message;

  MakeActionErrorState(this.message);
}
