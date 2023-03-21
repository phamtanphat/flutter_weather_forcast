import 'package:equatable/equatable.dart';

abstract class WeatherFromLocationEventBase extends Equatable{}

class SearchFromLocationEvent {
  String location;

  SearchFromLocationEvent({required this.location});
}