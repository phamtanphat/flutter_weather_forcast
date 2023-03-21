import 'package:dio/dio.dart';
import 'package:flutter_weather_forcast/data/api/api_request.dart';
import 'package:flutter_weather_forcast/data/model/WeatherForcast.dart';

class WeatherRepository {
  late ApiRequest _apiRequest;

  WeatherRepository({required ApiRequest apiRequest}) {
    _apiRequest = apiRequest;
  }

  Future searchWeatherFromLocation({String location = ""}) async{
    try {
      Response response = await _apiRequest.requestWeatherFromLocation(location: location);
      WeatherForecast weatherForecast = WeatherForecast.fromJson(response.data);
      print(weatherForecast.main?.temp);
    } on DioError catch(e){
      print(e.response?.data["message"]);
    } catch(e) {
      print("Error ${e.toString()}");
    }
  }
}

void main() {
  var weatherRepo = WeatherRepository(apiRequest: ApiRequest());
  weatherRepo.searchWeatherFromLocation(location: "abc");
}