import 'dart:async';

import 'package:flutter_weather_forcast/data/model/WeatherForcast.dart';
import 'package:flutter_weather_forcast/data/repositories/weather_repository.dart';
import 'package:flutter_weather_forcast/presentations/page/weather_location/bloc/weather_from_location_event.dart';

class WeatherFromLocationBloc {
  WeatherRepository? _weatherRepository;
  StreamController<WeatherFromLocationEventBase> _eventController = StreamController();
  StreamController<WeatherForecast> _weatherForecastController = StreamController();


  Stream<WeatherForecast> getWeatherForecast() {
    return _weatherForecastController.stream;
  }

  void addEvent(WeatherFromLocationEventBase event) {
    _eventController.sink.add(event);
  }

  WeatherFromLocationBloc() {
    _eventController.stream.listen((event) {
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
        .then((weatherForecast) => _weatherForecastController.add(weatherForecast))
        .catchError((error) => _weatherForecastController.addError(event));
  }

  void dispose() {
    _eventController.close();
    _weatherForecastController.close();
  }
}