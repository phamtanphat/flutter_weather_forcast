import 'package:equatable/equatable.dart';

abstract class WeatherFromLocationEventBase extends Equatable{}

class SearchFromLocationEvent extends WeatherFromLocationEventBase{
  String location;

  SearchFromLocationEvent({required this.location});

  @override
  List<Object?> get props => [];
}