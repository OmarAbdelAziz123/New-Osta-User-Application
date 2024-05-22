import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osta_user_app/features/home/models/address/city_index_model.dart';
import 'package:osta_user_app/features/home/models/address/country_index_model.dart';
import 'package:osta_user_app/features/home/models/address/get_all_addresses_model.dart';
import 'package:osta_user_app/features/home/models/services/all_services_model.dart';
import 'package:osta_user_app/features/home/models/services/sub_service_in_id_three_model.dart';
import 'package:osta_user_app/features/home/models/services/sub_service_model.dart';
import 'package:osta_user_app/utils/constants/api_constants.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/dio/dio_helper.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  AllServicesModel allServicesModel = AllServicesModel();
  SubServiceModel subServiceModel = SubServiceModel();
  SubServiceInIdThreeModel subServiceInIdThreeModel = SubServiceInIdThreeModel();

  // Result allServicesModel = Result();
  // List<Result> allServicesModel = [];

  CountryIndexModel countryIndexModel = CountryIndexModel();
  CityIndexModel cityIndexModel = CityIndexModel();

  List<String> countries = [];
  List<String> cities = [];
  Map<String, int> countryNameToIdMap = {};
  Map<String, int> cityNameToIdMap = {};

  GetAllAddressesModel getAllAddressesModel = GetAllAddressesModel();

  /// Services Function
  Future<void> getAllServicesFunction() async {
    emit(AllServicesLoadingState());
    await dioHelper.getData(endPoint: ApiConstants.servicesUrl).then((
        response) {
      allServicesModel = AllServicesModel.fromJson(response.data);
      emit(AllServicesSuccessState());
    }).catchError((error) {
      emit(AllServicesErrorState());
    });
  }

  /// Sub Services Function
  Future<void> getSubServicesFunction({required int serviceId}) async {
    emit(SubServicesLoadingState());
    await dioHelper.getData(
        endPoint: '${ApiConstants.subServiceUrl}?service_id=$serviceId').then((
        response) {
      subServiceModel = SubServiceModel.fromJson(response.data);
      // log(response.data);
      emit(SubServicesSuccessState());
    }).catchError((error) {
      log(error);
      emit(SubServicesErrorState());
    });
  }

  /// Sub Services In Id 3
  Future<void> getSubServicesInIdThreeFunction({required int serviceId}) async {
    emit(SubServicesInIdThreeLoadingState());
    await dioHelper.getData(endPoint: '${ApiConstants
        .subServiceUrl}?service_id=$serviceId&group_by_type=type').then((
        response) {
      print(response.data);
      subServiceInIdThreeModel =
          SubServiceInIdThreeModel.fromJson(response.data);
      // log(response.data);
      emit(SubServicesInIdThreeSuccessState());
    }).catchError((error) {
      print(error);
      emit(SubServicesInIdThreeErrorState());
    });
  }

  /// Make Order Function
  Future<void> makeOrderFunction({
    required String category,
    int? warrantyId,
    String? space,
    String? description,
    required int serviceId,
    int? unknownProblem,
    required int locationId,
    List<int>? subServicesIds,
    List<int>? subServiceQuantities,
    List<File>? images,
    required bool isSpace,
    required bool isSubServicesIds,
    required bool isSubServiceQuantities,
    required bool isWarrantyId,
  }) async {
    emit(MakeOrderLoadingState());

    String imagesString = images?.map((image) => 'images[]=${image.path}').join('&') ?? '';

    FormData formData = FormData.fromMap({
      'sub_services_ids[]': subServicesIds,
      'sub_service_quantities[]': subServiceQuantities,
      'category': category,
      'space': space,
      'warranty_id': warrantyId,
      'desc': description,
      'service_id': serviceId,
      'location_id': locationId,
      'unknown_problem': unknownProblem,
    });

    Options options = Options(headers: {
      'authorization': "Bearer ${OCacheHelper.getString(key: CacheKeys.token)}"
    });

    // Check if images is not null before adding to the URL
    String url = '${ApiConstants
        .baseUrl}api/user/order';
    if (images != null) {
      url += '&$imagesString';
    }

    await Dio()
        .post(
      url,
      data: formData,
      options: options,
    ).then((response) {
      print(response.data);
      emit(MakeOrderSuccessState());
    }).catchError((error) {
      print(error);
      emit(MakeOrderErrorState());
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

  /// City Index
  Future<void> getAllCitiesFunction({required int countryId}) async {
    emit(CityIndexLoadingState());
    await dioHelper.getData(endPoint: '${ApiConstants.cityUrl}?country_id=$countryId').then((response) {
      cityIndexModel = CityIndexModel.fromJson(response.data);
      log(cityIndexModel.result![0].name.toString());

      /// Clear the countries list to avoid duplications if this function is called multiple times
      cities.clear();
      cityNameToIdMap.clear();

      /// Adding each country's name to the cities list
      for (var city in cityIndexModel.result!) {
        cities.add(city.name!);
        cityNameToIdMap[city.name!] = city.id!;
      }

      /// Log the list of country names, if needed for verification
      log(cities.toString());

      emit(CityIndexSuccessState());
    }).catchError((error) {
      log(error);
      emit(CityIndexErrorState());
    });
  }

  /// Get All Addresses Function
  Future<void> getAllAddressesFunction() async {
    emit(GetAllAddressesLoadingState());
    await dioHelper.getData(endPoint: ApiConstants.getAllAddressesUrl).then((
        response) {
      getAllAddressesModel = GetAllAddressesModel.fromJson(response.data);
      emit(GetAllAddressesSuccessState());
    }).catchError((error) {
      emit(GetAllAddressesErrorState());
    });
  }

  /// Update All Addresses Function
  Future<void> updateAddressesFunction({required Response<dynamic> response}) async {
    Map<String, dynamic>? responseData = response.data;
    if (responseData != null) {
      getAllAddressesModel = GetAllAddressesModel.fromJson(responseData);
    }
  }


  /// Add Data For New Addresses Function
  Future<void> addDataForNewAddressesFunction({
    required String name,
    required String streetName,
    required int apartmentNumber,
    required int floorNumber,
    required int cityId,
    required String description,
    required String latitude,
    required String longitude,
}) async {
    emit(AddDataForNewAddressesLoadingState());
    await dioHelper.postData(endPoint: '${ApiConstants.getAllAddressesUrl}?name=$name&street=$streetName&apartment_number=$apartmentNumber&floor_number=$floorNumber&city_id=$cityId&desc=$description&latitude=$latitude&longitude=$longitude').then((response) {
      updateAddressesFunction(response: response);
      getAllAddressesModel.result = GetAllAddressesModel.fromJson(response.data).result;
      // log(response.data.toString());
      emit(AddDataForNewAddressesSuccessState());
    }).catchError((error) {
      emit(AddDataForNewAddressesErrorState());
    });
  }
}