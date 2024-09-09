import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_weather/data/models/response/clouds.dart';
import 'package:my_weather/data/models/response/coord.dart';
import 'package:my_weather/data/models/response/main.dart';
import 'package:my_weather/data/models/response/rain.dart';
import 'package:my_weather/data/models/response/sys.dart';
import 'package:my_weather/data/models/response/weather.dart';
import 'package:my_weather/data/models/response/wind.dart';

part 'current_weather_response.freezed.dart';
part 'current_weather_response.g.dart';

@freezed
class CurrentWeatherResponse with _$CurrentWeatherResponse {
  factory CurrentWeatherResponse({
    @JsonKey(name: 'coord') Coord? coord,
    @JsonKey(name: 'weather') List<Weather>? weather,
    @JsonKey(name: 'base') String? base,
    @JsonKey(name: 'main') Main? main,
    @JsonKey(name: 'visibility') int? visibility,
    @JsonKey(name: 'wind') Wind? wind,
    @JsonKey(name: 'clouds') Clouds? clouds,
    @JsonKey(name: 'rain') Rain? rain,
    @JsonKey(name: 'dt') int? dt,
    @JsonKey(name: 'sys') Sys? sys,
    @JsonKey(name: 'timezone') int? timezone,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'cod') int? cod,
  }) = _CurrentWeatherResponse;

  factory CurrentWeatherResponse.fromJson(Map<String, Object?> json) =>
      _$CurrentWeatherResponseFromJson(json);
}
