import 'dart:async';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter_weather_forcast/data/api/api_request.dart';
import 'package:flutter_weather_forcast/data/model/WeatherForcast.dart';

class WeatherRepository {
  late ApiRequest _apiRequest;

  void setApiRequest(ApiRequest apiRequest) {
    _apiRequest = apiRequest;
  }

  Future<WeatherForecast> searchWeatherFromLocation({String location = ""}) async{
    Completer<WeatherForecast> completerWeather = Completer();
    ReceivePort port = ReceivePort();
    try {
      Response response = await _apiRequest.requestWeatherFromLocation(location: location);
      final isolate = await Isolate.spawn(parseWeather, [port.sendPort, response.data]);
      WeatherForecast weatherForecast = await port.first;
      isolate.kill(priority: Isolate.immediate);
      completerWeather.complete(weatherForecast);
    } on DioError catch(e){
      completerWeather.completeError(e.response?.data["message"]);
    } catch(e) {
      completerWeather.completeError(e.toString());
    }
    return completerWeather.future;
  }

  static void parseWeather(List<dynamic> param) {
    SendPort sendPort = param[0];
    sendPort.send(WeatherForecast.fromJson(param[1]));
  }
}