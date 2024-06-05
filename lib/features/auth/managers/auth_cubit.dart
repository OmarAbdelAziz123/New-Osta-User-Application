import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osta_user_app/features/auth/models/address/country_index_model.dart';
import 'package:osta_user_app/features/auth/models/check_phone_model.dart';
import 'package:osta_user_app/features/auth/models/fill_your_account/fill_your_account.dart';
import 'package:osta_user_app/features/auth/models/user_data.dart';
import 'package:osta_user_app/features/auth/models/user_data_after_verified.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/dio/dio_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  UserData userData = UserData();

  CheckPhoneModel checkPhoneModel = CheckPhoneModel();

  UserDataAfterVerified userDataAfterVerified = UserDataAfterVerified();

  FillYourAccount fillYourAccount = FillYourAccount();

  CountryIndexModel countryIndexModel = CountryIndexModel();

  List<String> countries = [];
  Map<String, int> countryNameToIdMap = {};


  /// Login Function
  Future<void> loginFunction({required String phoneNumber}) async {
    emit(LoginLoadingState());
    await dioHelper.postData(endPoint: '${ApiConstants.loginUrl}?phone=$phoneNumber').then((response) {
      checkPhoneModel = CheckPhoneModel.fromJson(response.data);
      log(response.data.toString());
      emit(LoginSuccessState());
    }).catchError((error) {
      print(error);
      emit(LoginErrorState());
    });
  }

  /// Verify OTP Function
  Future<void> verifyOTPFunction({required String otp, required String phoneNumber}) async {
    emit(VerifyOTPLoadingState());
    await dioHelper.postData(endPoint: ApiConstants.verifyOTPUrl, body: {
      'otp': '1234',
      'phone': phoneNumber,
    }).then((response) {
      userDataAfterVerified = UserDataAfterVerified.fromJson(response.data);
      OCacheHelper.putString(key: CacheKeys.token, value: userDataAfterVerified.result!.token!);
      OCacheHelper.putString(key: CacheKeys.email, value: userDataAfterVerified.result!.email!);
      OCacheHelper.putString(key: CacheKeys.fullName, value: userDataAfterVerified.result!.name!);
      OCacheHelper.putString(key: CacheKeys.countryId, value: userDataAfterVerified.result!.countryId.toString());
      log(userDataAfterVerified.result!.token!);
      emit(VerifyOTPSuccessState());
    }).catchError((error) {
      log(error);
      emit(VerifyOTPErrorState());
    });
  }

  /// Fill Your Account
  Future<void> fillYourAccountFunction({required String name, required String email, required String countryId, required String phone, required String gender}) async {
    emit(FillYourAccountLoadingState());
    await dioHelper.postData(endPoint: ApiConstants.fillYourAccountUrl, body: {
      'name': name,
      'email': email,
      'phone': phone,
      'country_id': countryId,
      'gender': gender,
    }).then((response) {
      fillYourAccount = FillYourAccount.fromJson(response.data);
      log(fillYourAccount.message.toString());
      emit(FillYourAccountSuccessState());
    }).catchError((error) {
      log(error);
      emit(FillYourAccountErrorState());
    });
  }
  
  /// Country Index
  Future<void> getAllCountriesFunction() async {
    emit(CountryIndexLoadingState());
    await dioHelper.getData(endPoint: ApiConstants.countryUrl).then((response) {
      countryIndexModel = CountryIndexModel.fromJson(response.data);
      log(countryIndexModel.result![0].name.toString());

      /// Clear the countries list to avoid duplications if this function is called multiple times
      countries.clear();
      countryNameToIdMap.clear();

      /// Adding each country's name to the countries list
      for (var country in countryIndexModel.result!) {
        countries.add(country.name!);
        countryNameToIdMap[country.name!] = country.id!;
      }

      /// Log the list of country names, if needed for verification
      log(countries.toString());

      emit(CountryIndexSuccessState());
    }).catchError((error) {
      log(error);
      emit(CountryIndexErrorState());
    });
  }
}
