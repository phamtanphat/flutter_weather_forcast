import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_weather_forcast/data/api/api_request.dart';
import 'package:flutter_weather_forcast/data/model/WeatherForcast.dart';

class WeatherRepository {
  late ApiRequest _apiRequest;

  WeatherRepository({required ApiRequest apiRequest}) {
    _apiRequest = apiRequest;
  }

  Future<WeatherForecast> searchWeatherFromLocation({String location = ""}) async{
    Completer<WeatherForecast> completerWeather = Completer();
    try {
      Response response = await _apiRequest.requestWeatherFromLocation(location: location);
      WeatherForecast weatherForecast = WeatherForecast.fromJson(response.data);
      completerWeather.complete(weatherForecast);
    } on DioError catch(e){
      completerWeather.completeError(e.response?.data["message"]);
    } catch(e) {
      completerWeather.completeError(e.toString());
    }
    return completerWeather.future;
  }
}