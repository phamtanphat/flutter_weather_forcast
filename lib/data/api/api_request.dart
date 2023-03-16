import 'package:dio/dio.dart';
import 'package:flutter_weather_forcast/common/app_constant.dart';
import 'package:flutter_weather_forcast/data/api/dio_client.dart';

class ApiRequest {
  late Dio _dio;

  ApiRequest() {
    _dio = DioClient.getDio();
  }

  Future searchWeatherFromLocation({String location = "Hanoi"}) {
    return _dio.get("data/2.5/weather", queryParameters: {
      "appid": AppConstant.APP_ID,
      "units": "metric",
      "q": location
    });
  }
}

void main() {
  var apiRequest = ApiRequest();
  apiRequest.searchWeatherFromLocation()
  .then((value) => print(value));
}
