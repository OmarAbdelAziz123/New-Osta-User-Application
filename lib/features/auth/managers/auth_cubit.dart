import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osta/features/auth/models/address/country_index_model.dart';
import 'package:osta/features/auth/models/check_phone_model.dart';
import 'package:osta/features/auth/models/fill_your_account/fill_your_account.dart';
import 'package:osta/features/auth/models/user_data.dart';
import 'package:osta/features/auth/models/user_data_after_verified.dart';
import 'package:osta/utils/constants/exports.dart';
import 'package:osta/utils/constants/log_util.dart';
import 'package:osta/utils/dio/dio_helper.dart';

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
    // await dioHelper.postData(endPoint: '${ApiConstants.loginUrl}?phone=$phoneNumber').then((response) {
    //   checkPhoneModel = CheckPhoneModel.fromJson(response.data);
    //   log(response.data.toString());
    //   emit(LoginSuccessState(message: checkPhoneModel.message));
    // }).catchError((error) {
    //   print(error);
    //   emit(LoginErrorState());
    // });
    try {
      final response = await dioHelper.postData(
        endPoint:'${ApiConstants.loginUrl}?phone=$phoneNumber',
      );

      if(response.statusCode == 422) {
        final errorMessage = response.data['message'] ?? 'Validation error';
        emit(LoginSuccessState(message: errorMessage));
      } else if (response.statusCode == 200) {
        checkPhoneModel = CheckPhoneModel.fromJson(response.data);
        emit(LoginSuccessState(message: checkPhoneModel.message));
      } else {
        emit(LoginErrorState());
      }
    } catch (error) {
      emit(LoginErrorState());
    }
  }

  /// Verify OTP Function
  // Future<void> verifyOTPFunction({required String otp, required String phoneNumber}) async {
  //   emit(VerifyOTPLoadingState());
  //   await dioHelper.postData(endPoint: ApiConstants.verifyOTPUrl, body: {
  //     'otp': otp,
  //     'phone': phoneNumber,
  //   }).then((response) {
  //     userDataAfterVerified = UserDataAfterVerified.fromJson(response.data);
  //     OCacheHelper.putString(key: CacheKeys.userId, value: userDataAfterVerified.result!.id.toString());
  //     OCacheHelper.putString(key: CacheKeys.token, value: userDataAfterVerified.result!.token!);
  //     OCacheHelper.putString(key: CacheKeys.fullName, value: userDataAfterVerified.result!.name!);
  //     OCacheHelper.putString(key: CacheKeys.email, value: userDataAfterVerified.result!.email ?? '');
  //     // log(userDataAfterVerified.result!.token!);
  //     if(response.statusCode == 422) {
  //       final errorMessage = response.data['message'] ?? 'Validation error';
  //       emit(VerifyOTPSuccessState(errorMessage));
  //     }
  //     emit(VerifyOTPSuccessState(response.data['message']));
  //   }).catchError((error) {
  //     if (error is DioError) {
  //       if (error.response?.statusCode == 422) {
  //         logError('-------------');
  //         logError(error.response?.statusCode.toString() ?? 'ASDF');
  //         logError('-------------');
  //         final errorMessage = error.response?.data['message'] ?? 'Validation error';
  //         emit(VerifyOTPErrorStateWithMessage(errorMessage));
  //       } else {
  //         logError('-------------');
  //         logError(error.response?.statusCode.toString() ?? 'ASDF');
  //         logError('-------------');
  //         emit(VerifyOTPErrorState());
  //       }
  //     } else {
  //       logError('-------------');
  //       logError(error.response?.statusCode.toString() ?? 'ASDF');
  //       logError('-------------');
  //       emit(VerifyOTPErrorState());
  //     }
  //     // log(error.toString());
  //   });
  // }
  Future<void> verifyOTPFunction({required String otp, required String phoneNumber}) async {
    emit(VerifyOTPLoadingState());
    try {
      final response = await dioHelper.postData(
        endPoint: ApiConstants.verifyOTPUrl,
        body: {'otp': otp, 'phone': phoneNumber},
      );

      if (response.statusCode == 422) {
        final errorMessage = response.data['message'] ?? 'Validation error';
        emit(VerifyOTPSuccessState(errorMessage));
      } else if(response.statusCode == 401) {
        final errorMessage = response.data['message'] ?? 'Validation error';
        emit(VerifyOTPSuccessState(errorMessage));
      } else {
        userDataAfterVerified = UserDataAfterVerified.fromJson(response.data);
        OCacheHelper.putString(key: CacheKeys.userId, value: userDataAfterVerified.result!.id.toString());
        OCacheHelper.putString(key: CacheKeys.token, value: userDataAfterVerified.result!.token!);
        OCacheHelper.putString(key: CacheKeys.fullName, value: userDataAfterVerified.result!.name!);
        OCacheHelper.putString(key: CacheKeys.email, value: userDataAfterVerified.result!.email ?? '');
        emit(VerifyOTPSuccessState(response.data['message']));
      }
    } catch (error) {
      emit(VerifyOTPErrorState());
    }
  }

  /// Fill Your Account
  Future<void> fillYourAccountFunction({
    required String name,
    required String email,
    required String countryId,
    required String phone,
    required String gender,
    required String personal,
    required String dateOfBirth,
  }) async {
    emit(FillYourAccountLoadingState());

    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'country_id': countryId,
        'gender': gender,
        'personal': await MultipartFile.fromFile(personal),
        'date_of_birth': dateOfBirth,
      });

      Options options = Options(
        headers: {
          'authorization': "Bearer ${OCacheHelper.getString(key: CacheKeys.token)}",
        },
      );

      final response = await Dio().post(
        '${ApiConstants.baseUrl}${ApiConstants.fillYourAccountUrl}',
        data: formData,
        options: options,
      );

      if (response.statusCode == 422) {
        final errorMessage = response.data['message'] ?? 'Validation error';
        emit(FillYourAccountErrorState(errorMessage));
      } else if (response.statusCode == 200) {
        fillYourAccount = FillYourAccount.fromJson(response.data);
        emit(FillYourAccountSuccessState(message: fillYourAccount.message));
      } else {
        final errorMessage = 'Unknown error occurred';
        emit(FillYourAccountErrorState(errorMessage));
      }
    } on DioError catch (error) {
      String errorMessage;
      if (error.response?.statusCode == 422) {
        errorMessage = error.response!.data['message'] ?? 'Validation error';
      } else {
        errorMessage = 'Network error occurred';
      }
      emit(FillYourAccountErrorState(errorMessage));
    } catch (error) {
      emit(FillYourAccountErrorState('Unexpected error occurred'));
    }
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
