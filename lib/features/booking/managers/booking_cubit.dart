import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osta/features/booking/models/get_orders_by_filter_model.dart';
import 'package:osta/features/booking/models/receipt_model.dart';
import 'package:osta/utils/constants/api_constants.dart';
import 'package:osta/utils/constants/log_util.dart';
import 'package:osta/utils/dio/dio_helper.dart';
part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitialState());

  static BookingCubit get(context) => BlocProvider.of(context);

  GetOrdersByFilterModel getOrdersByFilterModel = GetOrdersByFilterModel();
  // ReceiptModel receiptModel = ReceiptModel();
  ReceiptModel? receiptModel;

  DioHelper dioHelper = DioHelper();

  /// Get Orders by Filter Function
  Future<void> getOrdersByFilterFunction({required String status}) async {
    emit(GetOrderByFilterLoadingState());
    await dioHelper
        .getData(endPoint: '${ApiConstants.orderUrl}?status=$status')
        .then((response) {
      logSuccess("getOrdersByFilterFunction response ${response.data}");
      getOrdersByFilterModel = GetOrdersByFilterModel.fromJson(response.data);
      emit(GetOrderByFilterSuccessState());
    }).catchError((error) {
      if (!isClosed) {
        log(error.toString());
        emit(GetOrderByFilterErrorState());
      }
    });
  }

  /// Get Receipt
  Future<void> getReceiptFunction({required String orderId}) async {
    if (receiptModel != null &&
        receiptModel!.result!.order!.id.toString() == orderId) {
      emit(GetReceiptSuccessState());
      return;
    }

    emit(GetReceiptLoadingState());
    await dioHelper.getData(endPoint: 'api/invoice/$orderId').then((response) {
      if (!isClosed) {
        receiptModel = ReceiptModel.fromJson(response.data);
        emit(GetReceiptSuccessState());
      }
    }).catchError((error) {
      if (!isClosed) {
        log(error.toString());
        emit(GetReceiptErrorState());
      }
    });
  }

  void clearReceiptData() {
    receiptModel = null;
    emit(BookingInitialState());
  }

// Future<void> getReceiptFunction({required String orderId}) async {
  //   emit(GetReceiptLoadingState());
  //   await dioHelper.getData(endPoint: 'api/invoice/$orderId').then((response) {
  //     if (!isClosed) {
  //       receiptModel = ReceiptModel.fromJson(response.data);
  //       emit(GetReceiptSuccessState());
  //     }
  //   }).catchError((error) {
  //     if (!isClosed) {
  //       log(error.toString());
  //       emit(GetReceiptErrorState());
  //     }
  //   });
  // }
}
