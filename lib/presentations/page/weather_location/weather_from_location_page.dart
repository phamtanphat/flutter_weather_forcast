import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_weather_forcast/data/api/api_request.dart';
import 'package:flutter_weather_forcast/data/model/WeatherForcast.dart';
import 'package:flutter_weather_forcast/data/repositories/weather_repository.dart';
import 'package:flutter_weather_forcast/presentations/page/weather_location/bloc/weather_from_location_bloc.dart';
import 'package:flutter_weather_forcast/presentations/page/weather_location/bloc/weather_from_location_event.dart';
import 'package:provider/provider.dart';
class WeatherFromLocationPage extends StatefulWidget {
  const WeatherFromLocationPage({Key? key}) : super(key: key);

  @override
  State<WeatherFromLocationPage> createState() => _WeatherFromLocationPageState();
}

class _WeatherFromLocationPageState extends State<WeatherFromLocationPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ApiRequest()),
        ProxyProvider<ApiRequest, WeatherRepository>(
          create: (context) => WeatherRepository(),
          update: (context, apiRequest, repository){
            if (repository == null) {
              return WeatherRepository()..setApiRequest(apiRequest);
            }
            repository.setApiRequest(apiRequest);
            return repository;
          },
        ),
        ProxyProvider<WeatherRepository, WeatherFromLocationBloc>(
          create: (context) => WeatherFromLocationBloc(),
          update: (context, repository, bloc){
            if (bloc == null) {
              return WeatherFromLocationBloc()..setWeatherRepository(repository);
            }
            bloc.setWeatherRepository(repository);
            return bloc;
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Weather from location"),
        ),
        body: WeatherForecastWidget()
      ),
    );
  }
}

class WeatherForecastWidget extends StatefulWidget {
  const WeatherForecastWidget({Key? key}) : super(key: key);

  @override
  State<WeatherForecastWidget> createState() => _WeatherForecastWidgetState();
}

class _WeatherForecastWidgetState extends State<WeatherForecastWidget> {

  late WeatherFromLocationBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.addEvent(SearchFromLocationEvent(location: "Hanoi"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          StreamBuilder<WeatherForecast>(
              stream: _bloc.getWeatherForecast(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text((snapshot.data?.name ??= "").toString()),
                        Text((snapshot.data?.main?.temp ??= 0).toString()),
                      ],
                    );
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                  default:
                    return CircularProgressIndicator();
                }
              }
          ),
          ElevatedButton(
              onPressed: () {
                var arrLocation = ["Hanoi", "London", "Sydney"];
                var random = Random();
                var index = random.nextInt(arrLocation.length);
                var location = arrLocation[index];
                _bloc.addEvent(SearchFromLocationEvent(location: location));
              },
              child: Text("Search location")
          )
        ],
      ),
    );
  }
}

