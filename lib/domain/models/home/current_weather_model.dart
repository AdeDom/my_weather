import 'package:my_weather/data/models/enum/app_weather.dart';

class CurrentWeatherModel {
  CurrentWeatherModel({
    required this.weather,
    required this.temp,
    required this.description,
    required this.tempMinMax,
    required this.humidity,
  });

  AppWeather weather;
  int? temp;
  String description;
  String tempMinMax;
  int? humidity;
}
