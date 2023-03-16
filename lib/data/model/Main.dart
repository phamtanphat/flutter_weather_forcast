class Main {
  double? temp;
  double? tempMin;
  double? tempMax;

  Main({this.temp, this.tempMin, this.tempMax});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
  }
}