import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osta/features/offer/models/inbox/get_all_messages_model.dart';
import 'package:osta/features/offer/models/inbox/make_order_is_done.dart';
import 'package:osta/features/offer/models/inbox/send_message_response.dart';
import 'package:osta/features/offer/models/offers/get_all_offers_to_me_model.dart';
import 'package:osta/features/offer/models/orders/get_all_orders_by_me.dart';
import 'package:osta/utils/constants/exports.dart';
import 'package:osta/utils/constants/log_util.dart';
import 'package:osta/utils/dio/dio_helper.dart';

part 'offers_orders_state.dart';

class OffersOrdersCubit extends Cubit<OffersOrdersState> {
  OffersOrdersCubit() : super(OffersOrdersInitialState());

  static OffersOrdersCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  GetAllOrdersToMeModel getAllOrdersToMeModel = GetAllOrdersToMeModel();

  GetAllOffersToMeModel getAllOffersToMeModel = GetAllOffersToMeModel();

  GetAllMessagesModel getAllMessagesModel = GetAllMessagesModel();
  List<Messages> messagesList = [];

  SendMessageResponseModel sendMessageResponse = SendMessageResponseModel();


  MakeOrderIsDoneModel makeOrderIsDone = MakeOrderIsDoneModel();


  /// Get All Orders Function
  Future<void> getAllOrdersByMeFunction() async {
    emit(GetAllOrdersLoadingState());
    await dioHelper.getData(endPoint: '${ApiConstants.orderUrl}?status=pending').then((
        response) {
      getAllOrdersToMeModel = GetAllOrdersToMeModel.fromJson(response.data);
      emit(GetAllOrdersSuccessState());
    }).catchError((error) {
      log(error);
      emit(GetAllOrdersErrorState());
    });
  }

  /// Get All Offers Function
  Future<void> getAllOffersByMeFunction({int? orderId}) async {
    emit(GetAllOffersLoadingState());

    String endPoint;
    if (orderId != null) {
      endPoint = 'api/user/order/$orderId/offer';
    } else {
      endPoint = 'api/user/order/offers';
    }

    await dioHelper.getData(endPoint: endPoint).then((response) {
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
      // log(error);
      emit(RejectOffersErrorState());
    });
  }

  /// Inbox Function
  Future<void> inboxFunction({
    String? orderId,
    String? conversationId,
    String? content,
    List<String>? mediaList,
  }) async {
    emit(InboxLoadingState());

    MultipartFile? image;
    if (mediaList != null && mediaList.isNotEmpty) {
      image = await MultipartFile.fromFile(mediaList[0]);
    }

    FormData formData = FormData.fromMap({
      if (orderId != null && orderId.isNotEmpty) 'order_id': orderId,
      if (conversationId != null && conversationId.isNotEmpty) 'conversation_id': conversationId,
      if (content != null && content.isNotEmpty) 'content': content,
      if (mediaList != null && mediaList.isNotEmpty) 'media[]': [image],
    });

    Options options = Options(headers: {
      'authorization': "Bearer ${OCacheHelper.getString(key: CacheKeys.token)}",
    });

    try {
      final response = await Dio().post(
        '${ApiConstants.baseUrl}api/message',
        data: formData,
        options: options,
      );

      if (response.statusCode == 422) {
        final errorMessage = response.data['message'] ?? 'Validation error';
        emit(InboxErrorState(errorMessage));
      } else if (response.statusCode == 200) {
        sendMessageResponse = SendMessageResponseModel.fromJson(response.data);
        logWarning(sendMessageResponse.toJson().toString());
        emit(InboxSuccessState());
      } else {
        const errorMessage = 'Unknown error occurred';
        emit(InboxErrorState(errorMessage));
      }
    } on DioError catch (error) {
      String errorMessage;
      if (error.response?.statusCode == 422) {
        errorMessage = error.response?.data['message'] ?? 'Validation error';
      } else {
        errorMessage = 'Network error occurred';
      }
      emit(InboxErrorState(errorMessage));
    } catch (error) {
      emit(InboxErrorState('Unexpected error occurred'));
    }
  }

  Future<void> makeOrderIsDoneFunc({required int orderId, required String paymentMethod}) async {
    emit(MakeOrderIsDoneLoadingState());

    logWarning(OCacheHelper.getString(key: CacheKeys.token).toString());

    try {
      final response = await dioHelper.postData(endPoint: 'api/provider/order/$orderId/make-done?payment_method=$paymentMethod');

      if(response.statusCode == 422) {
        final errorMessage = response.data['message'] ?? 'Validation error';
        emit(MakeOrderIsDoneErrorState(errorMessage));
      } else if(response.statusCode == 200) {
        makeOrderIsDone = MakeOrderIsDoneModel.fromJson(response.data);
        emit(MakeOrderIsDoneSuccessState());
      } else if(response.statusCode == 401) {
        final errorMessage = response.data['message'] ?? 'Unauthenticated or Token Expired, Please Login';
        emit(MakeOrderIsDoneErrorState(errorMessage));
      } else {
        const errorMessage = 'Unknown error occurred';
        emit(MakeOrderIsDoneErrorState(errorMessage));
      }
    } on DioError catch (error) {
      String errorMessage;
      if (error.response?.statusCode == 422) {
        errorMessage = error.response?.data['message'] ?? 'Validation error';
      } else {
        errorMessage = 'Network error occurred';
      }
      emit(MakeOrderIsDoneErrorState(errorMessage));
    } catch (error) {
      emit(MakeOrderIsDoneErrorState('Unexpected error occurred'));
    }
  }
  Future<void> makeActionFunc({required int messageId, required String responseValue}) async {
    emit(MakeActionLoadingState());

    try {
      final response = await dioHelper.postData(endPoint: 'api/message/response-action', body: {
        'message_id': messageId,
        'response_value': responseValue,
      });

      if(response.statusCode == 422) {
        final errorMessage = response.data['message'] ?? 'Validation error';
        emit(MakeActionErrorState(errorMessage));
      } else if(response.statusCode == 200) {
        // getAllMessagesModel = GetAllMessagesModel.fromJson(response.data);
        sendMessageResponse = SendMessageResponseModel.fromJson(response.data);
        emit(MakeActionSuccessState());
      } else if(response.statusCode == 401) {
        final errorMessage = response.data['message'] ?? 'Unauthenticated or Token Expired, Please Login';
        emit(MakeActionErrorState(errorMessage));
      } else {
        const errorMessage = 'Unknown error occurred';
        emit(MakeActionErrorState(errorMessage));
      }
    } on DioError catch (error) {
      String errorMessage;
      if (error.response?.statusCode == 422) {
        errorMessage = error.response?.data['message'] ?? 'Validation error';
      } else {
        errorMessage = 'Network error occurred';
      }
      emit(MakeActionErrorState(errorMessage));
    } catch (error) {
      emit(MakeActionErrorState('Unexpected error occurred'));
    }
  }


  /// Get All Messages
  Future<void> getAllMessagesFunction({
    String? orderId,
    String? conversationId,
    int? perPage,
    int? page,
  }) async {
    // getAllMessagesModel = GetAllMessagesModel();
    emit(GetAllMessagesLoadingState());
    log('Before Comes Data');

    String url = '';

    if(orderId != null) {
      url = 'api/message?order_id=$orderId';
    } else if(conversationId != null) {
      url = 'api/message?conversation_id=$conversationId';
    }

    await dioHelper.getData(endPoint: url).then((response) {
      log('After Comes Data $response');
      getAllMessagesModel = GetAllMessagesModel.fromJson(response.data);
      // messagesList.addAll(getAllMessagesModel.result!);
      if(getAllMessagesModel.result!.messages!.isNotEmpty) {
        getAllMessagesModel.result!.messages!.forEach((element) {
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
