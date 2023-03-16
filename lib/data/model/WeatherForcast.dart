import 'Main.dart';
import 'Weather.dart';

class WeatherForecast {
  List<Weather>? weather;
  Main? main;
  int? dt;
  int? id;
  String? name;

  WeatherForecast({this.weather, this.main, this.dt, this.id, this.name});

  WeatherForecast.fromJson(Map<String, dynamic> json) {
    weather ??= [];
    json['weather']?.forEach((v) {
      weather?.add(Weather.fromJson(v));
    });
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    dt = json['dt'];
    id = json['id'];
    name = json['name'];
  }
}