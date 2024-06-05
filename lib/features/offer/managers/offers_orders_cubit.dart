import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osta_user_app/features/offer/models/inbox/get_all_messages_model.dart';
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

  GetAllMessagesModel getAllMessagesModel = GetAllMessagesModel();
  List<MessageResult> messagesList = [];

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
    await dioHelper.postData(endPoint: 'api/user/offer/$offerId/accept').then((
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
    await dioHelper.postData(endPoint: 'api/user/offer/$offerId/reject').then((
        response) {
      emit(RejectOffersSuccessState());
    }).catchError((error) {
      log(error);
      emit(RejectOffersErrorState());
    });
  }

  /// Inbox Function
  Future<void> inboxFunction({
    required String orderId,
    String? content,
    List<String>? mediaList,
  }) async {
    emit(InboxLoadingState());

    MultipartFile? image;
    if(mediaList != null) image = await MultipartFile.fromFile(mediaList[0]);

    FormData formData = FormData.fromMap({
      'order_id': orderId,
      if(content != null && content.isNotEmpty) 'content': content,
      if(mediaList != null && mediaList.isNotEmpty) 'media[]' : [image]
    });

    Options options = Options(headers: {
      'authorization': "Bearer ${OCacheHelper.getString(key: CacheKeys.token)}"
    });

    await Dio()
        .post(
      '${ApiConstants.baseUrl}api/message',
      data: formData,
      options: options,
    ).then((response) {
      print(response.data);
      emit(InboxSuccessState());
    }).catchError((error) {
      print('error in send messages in $error');
      emit(InboxErrorState());
    });
  }

  /// Get All Messages
  Future<void> getAllMessagesFunction({String? orderId, int? perPage, int? page}) async {
    // getAllMessagesModel = GetAllMessagesModel();
    emit(GetAllMessagesLoadingState());
    log('Before Comes Data');
    await dioHelper.getData(endPoint: 'api/message?order_id=$orderId&per_page=10&page=$page').then((
        response) {
      log('After Comes Data $response');
      getAllMessagesModel = GetAllMessagesModel.fromJson(response.data);
      // messagesList.addAll(getAllMessagesModel.result!);
      if(getAllMessagesModel.result!.isNotEmpty) {
        getAllMessagesModel.result!.forEach((element) {
          messagesList.add(element);
        });
      }
      emit(GetAllMessagesSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetAllMessagesErrorState());
    });
  }
}
