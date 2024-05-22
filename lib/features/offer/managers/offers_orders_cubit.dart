import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osta_user_app/features/offer/models/offers/get_all_offers_to_me_model.dart';
import 'package:osta_user_app/features/offer/models/orders/get_all_orders_by_me.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/dio/dio_helper.dart';

part 'offers_orders_state.dart';

class OffersOrdersCubit extends Cubit<OffersOrdersState> {
  OffersOrdersCubit() : super(OffersOrdersInitialState());

  static OffersOrdersCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  GetAllOrdersToMeModel getAllOrdersToMeModel = GetAllOrdersToMeModel();

  GetAllOffersToMeModel getAllOffersToMeModel = GetAllOffersToMeModel();

  /// Get All Orders Function
  Future<void> getAllOrdersByMeFunction() async {
    emit(GetAllOrdersLoadingState());
    await dioHelper.getData(endPoint: ApiConstants.orderUrl).then((
        response) {
      getAllOrdersToMeModel = GetAllOrdersToMeModel.fromJson(response.data);
      emit(GetAllOrdersSuccessState());
    }).catchError((error) {
      log(error);
      emit(GetAllOrdersErrorState());
    });
  }

  /// Get All Offers Function
  Future<void> getAllOffersByMeFunction({required int orderId}) async {
    emit(GetAllOffersLoadingState());
    await dioHelper.getData(endPoint: 'api/user/order/$orderId/offer').then((
        response) {
      getAllOffersToMeModel = GetAllOffersToMeModel.fromJson(response.data);
      emit(GetAllOffersSuccessState());
    }).catchError((error) {
      log(error);
      emit(GetAllOffersErrorState());
    });
  }

  /// Accept to Specific Offers Function
  Future<void> acceptOffersByMeFunction({required int offerId}) async {
    emit(AcceptOffersLoadingState());
    await dioHelper.patchData(endPoint: 'api/user/offer/$offerId/accept').then((
        response) {
      emit(AcceptOffersSuccessState());
    }).catchError((error) {
      log(error);
      emit(AcceptOffersErrorState());
    });
  }

  /// Reject to Specific Offers Function
  Future<void> rejectOffersByMeFunction({required int offerId}) async {
    emit(RejectOffersLoadingState());
    await dioHelper.patchData(endPoint: 'api/user/offer/$offerId/reject').then((
        response) {
      emit(RejectOffersSuccessState());
    }).catchError((error) {
      log(error);
      emit(RejectOffersErrorState());
    });
  }
}
