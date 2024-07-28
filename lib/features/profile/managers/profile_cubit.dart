import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osta_user_app/features/profile/models/help_center/get_all_faqs_index_model.dart';
import 'package:osta_user_app/features/profile/models/help_center/get_all_faqs_model.dart';
import 'package:osta_user_app/features/profile/models/help_center/get_tickets_customer_services_model.dart';
import 'package:osta_user_app/features/profile/models/help_center/send_ticket_response_model.dart';
import 'package:osta_user_app/features/profile/models/profile_data/get_profile_data_model.dart';
import 'package:osta_user_app/features/profile/models/profile_data/update_response_model.dart';
import 'package:osta_user_app/utils/constants/api_constants.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';
import 'package:osta_user_app/utils/dio/dio_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  GetProfileDataModel getProfileDataModel = GetProfileDataModel();

  GetAllFaqsModel getAllFaqsModel = GetAllFaqsModel();
  GetAllFaqsIndexModel getAllFaqsIndexModel = GetAllFaqsIndexModel();
  UpdateResponseModel updateResponseModel = UpdateResponseModel();
  SendTicketResponseModel sendTicketResponseModel = SendTicketResponseModel();
  GetTicketsModel getTicketsModel = GetTicketsModel();

  List<AllDataIndex> allDataIndex = [];


  /// Get Profile Data Function
  Future<void> getAllProfileDataFunc() async {
    emit(GetProfileDataLoadingState());
    await dioHelper.getData(endPoint: ApiConstants.getProfileDataUrl).then((response) {
      getProfileDataModel = GetProfileDataModel.fromJson(response.data);
      emit(GetProfileDataSuccessState());
    }).catchError((error) {
      logError(error.toString());
      emit(GetProfileDataErrorState());
    });
  }

  /// Update Profile Data Function
  Future<void> updateProfileDataFunc({
    String? name,
    String? email,
    String? phone,
    String? countryId,
    String? gender,
    String? dateOfBirth,
    String? personal,
  }) async {
    emit(UpdateProfileDataLoadingState());

    FormData formData;

    if (personal != null) {
      formData = FormData.fromMap({'personal': await MultipartFile.fromFile(personal)});
    }
    else {
      formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'country_id': countryId,
        'gender': gender,
        'date_of_birth': dateOfBirth,
      });
    }

    await dioHelper.postDataInFormData(endPoint: ApiConstants.profileDataUrl, body: formData).then((response) {
      updateResponseModel = UpdateResponseModel.fromJson(response.data);

      if (personal != null) {
        getProfileDataModel.result = updateResponseModel.result;
      } else {
        getProfileDataModel.result = updateResponseModel.result;
        // getProfileDataModel.result = UserData(
        //   id: updateResponseModel.result?.id,
        //   phone: updateResponseModel.result?.phone,
        //   name: updateResponseModel.result?.name,
        //   country: updateResponseModel.result?.country,
        //   countryId: updateResponseModel.result!.countryId,
        //   dateOfBirth: updateResponseModel.result?.dateOfBirth,
        //   email: updateResponseModel.result?.email,
        //   gender: updateResponseModel.result?.gender,
        //   token: updateResponseModel.result?.token,
        // );
      }

      emit(UpdateProfileDataSuccessState());
    }).catchError((error) {
      logError(error.toString());
      emit(UpdateProfileDataErrorState());
    });
  }



  /// Get All Faqs Function
  Future<void> getAllFaqsCategoryFunc() async {
    emit(GetAllFaqsCategoryLoadingState());
    await dioHelper.getData(endPoint: ApiConstants.faqCategoryUrl).then((response) {
      getAllFaqsModel = GetAllFaqsModel.fromJson(response.data);
      emit(GetAllFaqsCategorySuccessState(resultList: getAllFaqsModel.result));
    }).catchError((error) {
      logError(error.toString());
      emit(GetAllFaqsCategoryErrorState());
    });
  }

  /// Get All Faqs Index Function
  // Future<void> getAllFaqsIndexCategoryFunc({required int categoryId}) async {
  Future<void> getAllFaqsIndexCategoryFunc({int? categoryId, String? search}) async {
    emit(GetAllFaqsCategoryIndexLoadingState());
    Map<String, String> queryParams = {};
    if (categoryId != null) {
      queryParams['category_id'] = categoryId.toString();
    }
    if (search != null) {
      queryParams['search'] = search;
    }

    /// Convert queryParams map to query string
    String queryString = queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');


    await dioHelper.getData(endPoint: '${ApiConstants.faqIndexUrl}?$queryString').then((response) {
      getAllFaqsIndexModel = GetAllFaqsIndexModel.fromJson(response.data);
      logSuccess(getAllFaqsIndexModel.allDataIndex!.length.toString());
      emit(GetAllFaqsCategoryIndexSuccessState());
    }).catchError((error) {
      logError(error.toString());
      emit(GetAllFaqsCategoryIndexErrorState());
    });
  }

  /// Make Messages Function
  Future<void> createTicketFunc({String? title}) async {
    emit(MakeMessagesLoadingState());

    FormData formData = FormData.fromMap({
      if(title != null && title.isNotEmpty) 'title': title,
    });

    await dioHelper.postFormData(endPoint: ApiConstants.customerServicesUrl, formData: formData).then((response) {
      sendTicketResponseModel = SendTicketResponseModel.fromJson(response.data);
      logSuccess(response.data.toString());
      emit(MakeMessagesSuccessState());
    }).catchError((error) {
      logError(error.toString());
      emit(MakeMessagesErrorState());
    });
  }

  /// Get Tickets Function
  Future<void> getTicketsFunc({required int pageCount}) async {
    emit(GetTicketsLoadingState());
    await dioHelper.getData(endPoint: '${ApiConstants.customerServicesUrl}?page=$pageCount').then((response) {
      getTicketsModel = GetTicketsModel.fromJson(response.data);
      emit(GetTicketsSuccessState());
    }).catchError((error) {
      logError(error.toString());
      emit(GetTicketsErrorState());
    });
  }
}
