import 'package:my_weather/data/models/enum/app_weather.dart';

class ForecastModel {
  ForecastModel({
    required this.weather,
    required this.temp,
    required this.tempMinMax,
    required this.dateTime,
  });

  AppWeather weather;
  int? temp;
  String tempMinMax;
  String dateTime;
}
