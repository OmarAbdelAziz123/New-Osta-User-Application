import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osta_user_app/features/booking/models/get_orders_by_filter_model.dart';
import 'package:osta_user_app/utils/constants/api_constants.dart';
import 'package:osta_user_app/utils/dio/dio_helper.dart';
part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitialState());

  static BookingCubit get(context) => BlocProvider.of(context);

  GetOrdersByFilterModel getOrdersByFilterModel = GetOrdersByFilterModel();

  DioHelper dioHelper = DioHelper();
  
  /// Get Orders by Filter Function
  Future<void> getOrdersByFilterFunction({required String status}) async {
    emit(GetOrderByFilterLoadingState());
    await dioHelper.getData(endPoint: '${ApiConstants.orderUrl}?status=$status').then((response) {
      getOrdersByFilterModel = GetOrdersByFilterModel.fromJson(response.data);
      emit(GetOrderByFilterSuccessState());
    }).catchError((error) {
      log(error);
      emit(GetOrderByFilterErrorState());
    });
  }
}
