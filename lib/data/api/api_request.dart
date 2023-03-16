import 'package:dio/dio.dart';
import 'package:flutter_weather_forcast/data/api/dio_client.dart';

class ApiRequest {
  late Dio _dio;

  ApiRequest() {
    _dio = DioClient.getDio();
  }

  void searchWeatherFromLocation() {

  }
}