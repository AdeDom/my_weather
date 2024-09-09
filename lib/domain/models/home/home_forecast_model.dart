import 'package:my_weather/data/models/enum/app_weather.dart';

class HomeForecastModel {
  HomeForecastModel({
    required this.weather,
    required this.temp,
    required this.time,
  });

  AppWeather weather;
  int? temp;
  String time;
}
