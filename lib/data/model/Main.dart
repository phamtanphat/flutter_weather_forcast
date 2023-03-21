class Main {
  num? temp;
  num? tempMin;
  num? tempMax;

  Main({this.temp, this.tempMin, this.tempMax});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
  }
}