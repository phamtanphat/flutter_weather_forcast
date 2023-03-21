import 'package:dio/dio.dart';
import 'package:flutter_weather_forcast/common/app_constant.dart';
import 'package:flutter_weather_forcast/data/api/dio_client.dart';

class ApiRequest {
  late Dio _dio;

  ApiRequest() {
    _dio = DioClient.getDio();
  }

  Future requestWeatherFromLocation({String location = "Hanoi"}) {
    location = location.isEmpty ? "Hanoi" : location;
    return _dio.get("data/2.5/weather", queryParameters: {
      "appid": AppConstant.APP_ID,
      "units": "metric",
      "q": location
    });
  }
}