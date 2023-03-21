import 'dart:async';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter_weather_forcast/data/api/api_request.dart';
import 'package:flutter_weather_forcast/data/model/WeatherForcast.dart';

class WeatherRepository {
  ApiRequest? _apiRequest;

  void setApiRequest(ApiRequest apiRequest) {
    _apiRequest = apiRequest;
  }

  Future<WeatherForecast> searchWeatherFromLocation({String location = ""}) async{
    Completer<WeatherForecast> completerWeather = Completer();
    ReceivePort receiveSuccessPort = ReceivePort();
    ReceivePort receiveErrorPort = ReceivePort();
    await Isolate.spawn((receivePort) async {
      try {
        Response response = await _apiRequest?.requestWeatherFromLocation(location: location);
        WeatherForecast weatherForecast = WeatherForecast.fromJson(response.data);
        receiveSuccessPort.sendPort.send(weatherForecast);
      } on DioError catch(e){
        receiveErrorPort.sendPort.send(e.response?.data["message"]);
      } catch(e) {
        receiveErrorPort.sendPort.send(e.toString());
      }
    }, [receiveSuccessPort, receiveErrorPort]);

    WeatherForecast weatherForecast = await receiveSuccessPort.first;
    String error = await receiveErrorPort.first;
    if (error.isNotEmpty) {
      completerWeather.completeError(error);
    } else {
      completerWeather.complete(weatherForecast);
    }

    return completerWeather.future;
  }
}