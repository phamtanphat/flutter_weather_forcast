class Weather {
  String? main;
  String? icon;

  Weather({this.main, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    main = json['main'];
    icon = json['icon'];
  }
}