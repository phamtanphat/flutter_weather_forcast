import 'package:flutter/material.dart';
class WeatherFromLocationPage extends StatefulWidget {
  const WeatherFromLocationPage({Key? key}) : super(key: key);

  @override
  State<WeatherFromLocationPage> createState() => _WeatherFromLocationPageState();
}

class _WeatherFromLocationPageState extends State<WeatherFromLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather from location"),
      ),
      body: Container(),
    );
  }
}
