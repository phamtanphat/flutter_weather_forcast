import 'package:dio/dio.dart';
import 'package:flutter_weather_forcast/common/app_constant.dart';

class DioClient {
  static final Dio _dio = DioClient._createDio();

  // private constructor
  DioClient._();

  static Dio getDio() {
    return _dio;
  }

  static Dio _createDio() {
    return Dio(BaseOptions(
      baseUrl: AppConstant.BASE_URL,
      connectTimeout: Duration(seconds: AppConstant.CONNECTION_TIME_OUT),
      receiveTimeout: Duration(seconds: AppConstant.RECEIVE_TIME_OUT),
      sendTimeout: Duration(seconds: AppConstant.SEND_TIME_OUT),
    ));
  }
}
