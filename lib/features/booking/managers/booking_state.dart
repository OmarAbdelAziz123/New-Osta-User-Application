part of 'booking_cubit.dart';

@immutable
abstract class BookingState {}

class BookingInitialState extends BookingState {}

/// Get Orders By Filter States
class GetOrderByFilterLoadingState extends BookingState {}

class GetOrderByFilterSuccessState extends BookingState {}

class GetOrderByFilterErrorState extends BookingState {}
