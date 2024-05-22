import 'dart:developer';
import 'package:osta_user_app/utils/constants/exports.dart';


class DioHelper {
  Dio dio = Dio();

  Future<Response> getData({required String endPoint}) async {
    Response response = await dio.get(
      ApiConstants.baseUrl + endPoint,
      options: Options(
        headers: {
          // "authorization": "Bearer 24|cHtABLwXiKzPtcxLkpGGIjQ21P24XldI4O7m3RCbcd5f7bb4",
          "authorization": "Bearer ${OCacheHelper.getString(key: CacheKeys.token)}",
        },
      ),
    );
    return response;
  }

  Future<Response> postData({
    bool handleError = true,
    required String endPoint,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {
      Response response = await dio.post(
        ApiConstants.baseUrl + endPoint,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            "authorization":
                "Bearer ${OCacheHelper.getString(key: CacheKeys.token)}",
          },
        ),
      );
      if (response.statusCode == 204 ||
          response.statusCode == 200 ||
          response.statusCode == 201) {
      } else if (response.statusCode == 403) {}
      return response;
    } on DioError {
      rethrow;
    }
  }

  Future<Response> postFormData({
    bool handleError = true,
    required String endPoint,
    FormData? formData,
    String? token,
  }) async {
    try {
      Response response = await dio.post(
        ApiConstants.baseUrl + endPoint,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            "authorization":
            "Bearer ${OCacheHelper.getString(key: CacheKeys.token)}",
          },
        ),
      );
      if (response.statusCode == 204 ||
          response.statusCode == 200 ||
          response.statusCode == 201) {
      } else if (response.statusCode == 403) {}
      return response;
    } on DioError {
      rethrow;
    }
  }

  Future<Response> postDataWithoutAuth({
    bool handleError = true,
    required String endPoint,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {
      Response response = await dio.post(
        ApiConstants.baseUrl + endPoint,
        data: body,
      );
      log(response.data);
      if (response.statusCode == 204 ||
          response.statusCode == 200 ||
          response.statusCode == 201) {
      } else if (response.statusCode == 403) {
        log(response.data);
      }
      return response;
    } on DioError {
      rethrow;
    }
  }

  Future<Response> putData({
    required String endPoint,
    Map<String, dynamic>? body,
  }) async {
    return await dio.put('${ApiConstants.baseUrl}$endPoint',
        data: body,
        options: Options(
          headers: {
            "authorization":
                "Bearer ${OCacheHelper.getString(key: CacheKeys.token)}",
          },
        ));
  }

  Future<Response> patchData({
    required String endPoint,
    Map<String, dynamic>? body,
  }) async {
    return await dio.patch('${ApiConstants.baseUrl}$endPoint',
        data: body,
        options: Options(headers: {
          "authorization": "Bearer ${OCacheHelper.getString(key: CacheKeys.token)}",
        }));
  }

  Future<Response> deleteFromCart({
    required String endPoint,
    Map<String, dynamic>? body,
  }) async {
    return await dio.put('${ApiConstants.baseUrl}$endPoint',
        data: body,
        options: Options(
          headers: {
            "authorization":
                "Bearer ${OCacheHelper.getString(key: CacheKeys.token)}",
          },
        ));
  }

  Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? body,
  }) async {
    return await dio.delete(ApiConstants.baseUrl + endPoint,
        data: body,
        options: Options(headers: {
          "authorization": "Bearer ${OCacheHelper.getString(key: CacheKeys.token)}",
        }));
  }

  static void logout(BuildContext context) async {
    await OCacheHelper.clearShared();
    /// TODO: Implement Screen To Logout
    context.pushReplacementNamed('');
    // Navigator.pushReplacementNamed(context, 'checkScreen');
  }
}
