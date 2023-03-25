import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_forcast/data/api/api_request.dart';
import 'package:flutter_weather_forcast/data/model/WeatherForcast.dart';

class WeatherRepository {
  late ApiRequest _apiRequest;

  void setApiRequest(ApiRequest apiRequest) {
    _apiRequest = apiRequest;
  }

  Future<WeatherForecast> searchWeatherFromLocation({String location = ""}) async{
    Completer<WeatherForecast> completerWeather = Completer();
    try {
      Response response = await _apiRequest.requestWeatherFromLocation(location: location);
      WeatherForecast weatherForecast = await compute(WeatherForecast.fromJson, response.data as Map<String, dynamic>);
      completerWeather.complete(weatherForecast);
    } on DioError catch(e){
      completerWeather.completeError(e.response?.data["message"]);
    } catch(e) {
      completerWeather.completeError(e.toString());
    }
    return completerWeather.future;
  }
}