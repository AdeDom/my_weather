import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_weather/data/models/response/clouds_response.dart';
import 'package:my_weather/data/models/response/coord_response.dart';
import 'package:my_weather/data/models/response/main_response.dart';
import 'package:my_weather/data/models/response/rain_response.dart';
import 'package:my_weather/data/models/response/sys_response.dart';
import 'package:my_weather/data/models/response/weather_response.dart';
import 'package:my_weather/data/models/response/wind_response.dart';

part 'current_weather_response.freezed.dart';
part 'current_weather_response.g.dart';

@freezed
class CurrentWeatherResponse with _$CurrentWeatherResponse {
  factory CurrentWeatherResponse({
    @JsonKey(name: 'coord') CoordResponse? coord,
    @JsonKey(name: 'weather') List<WeatherResponse>? weather,
    @JsonKey(name: 'base') String? base,
    @JsonKey(name: 'main') MainResponse? main,
    @JsonKey(name: 'visibility') int? visibility,
    @JsonKey(name: 'wind') WindResponse? wind,
    @JsonKey(name: 'clouds') CloudsResponse? clouds,
    @JsonKey(name: 'rain') RainResponse? rain,
    @JsonKey(name: 'dt') int? dt,
    @JsonKey(name: 'sys') SysResponse? sys,
    @JsonKey(name: 'timezone') int? timezone,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'cod') int? cod,
  }) = _CurrentWeatherResponse;

  factory CurrentWeatherResponse.fromJson(Map<String, Object?> json) =>
      _$CurrentWeatherResponseFromJson(json);
}
