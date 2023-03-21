import 'dart:async';

import 'package:flutter_weather_forcast/data/model/WeatherForcast.dart';
import 'package:flutter_weather_forcast/data/repositories/weather_repository.dart';
import 'package:flutter_weather_forcast/presentations/page/weather_location/bloc/weather_from_location_event.dart';

class WeatherFromLocationBloc {
  WeatherRepository? _weatherRepository;
  StreamController<WeatherFromLocationEventBase> eventController = StreamController();
  StreamController<WeatherForecast> weatherForecastController = StreamController();
  
  WeatherFromLocationBloc() {
    eventController.stream.listen((event) { 
      switch(event.runtimeType) {
        case SearchFromLocationEvent:
          searchWeatherFromLocation(event as SearchFromLocationEvent);
          break;
      }
    });
  }
  
  void setWeatherRepository(WeatherRepository repository) {
    _weatherRepository = repository;
  }

  void searchWeatherFromLocation(SearchFromLocationEvent event) {
    _weatherRepository?.searchWeatherFromLocation(location: event.location)
        .then((weatherForecast) => weatherForecastController.add(weatherForecast))
        .catchError((error) => weatherForecastController.addError(event));
  }

  void dispose() {
    eventController.close();
    weatherForecastController.close();
  }
}