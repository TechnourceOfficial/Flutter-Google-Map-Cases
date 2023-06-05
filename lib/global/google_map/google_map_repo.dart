import 'package:dio/dio.dart';
import 'package:google_map_modules/global/google_map/place_auto_complete_response.dart';
import 'package:google_map_modules/global/google_map/place_details_response.dart';

import '../utils/config.dart';
import '../utils/logger.dart';
import '../utils/logging_intercepter.dart';

class GoogleMapRepo {
  static String msg = "";

  static Dio dio = Dio();

  GoogleMapRepo._();

  static Future<void> init() async {
    dio = Dio(BaseOptions(
        baseUrl: Config.googleMapBaseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60)));
    dio.interceptors.add(LoggingInterceptor());
  }

  ///google map get places api
  static Future<PlaceAutoCompleteResponse> getPlaces(String query) async {
    var queryParameters = {"input": query, "key": Config.kGoogleApiKey};
    try {
      final Response response = await dio.get(
        Config.getPlaces,
        queryParameters: queryParameters,
        options: Options(headers: getHeader()),
      );
      return PlaceAutoCompleteResponse.fromJson(response.data);
    } catch (e) {
      Logger.logPrint(e);
      rethrow;
    }
  }

  ///google map get places details api
  static Future<PlaceDetailsResponse> getPlaceDetail(String placeId) async {
    var queryParameters = {"place_id": placeId, "key": Config.kGoogleApiKey};
    try {
      final Response response = await dio.get(Config.getPlacesDetails,
          queryParameters: queryParameters,
          options: Options(headers: getHeader()));
      return PlaceDetailsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  static getHeader() {
    Map<String, dynamic> headers = <String, dynamic>{};
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    return headers;
  }
}
