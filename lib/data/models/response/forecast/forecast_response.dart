import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_weather/data/models/response/clouds.dart';
import 'package:my_weather/data/models/response/coord.dart';
import 'package:my_weather/data/models/response/main.dart';
import 'package:my_weather/data/models/response/rain.dart';
import 'package:my_weather/data/models/response/sys.dart';
import 'package:my_weather/data/models/response/weather.dart';
import 'package:my_weather/data/models/response/wind.dart';

part 'forecast_response.freezed.dart';
part 'forecast_response.g.dart';

@freezed
class ForecastResponse with _$ForecastResponse {
  factory ForecastResponse({
    @JsonKey(name: 'cod') String? cod,
    @JsonKey(name: 'message') int? message,
    @JsonKey(name: 'cnt') int? cnt,
    @JsonKey(name: 'list') List<Forecast>? list,
    @JsonKey(name: 'city') City? city,
  }) = _ForecastResponse;

  factory ForecastResponse.fromJson(Map<String, Object?> json) =>
      _$ForecastResponseFromJson(json);
}

@freezed
class Forecast with _$Forecast {
  factory Forecast({
    @JsonKey(name: 'dt') int? dt,
    @JsonKey(name: 'main') Main? main,
    @JsonKey(name: 'weather') List<Weather>? weather,
    @JsonKey(name: 'clouds') Clouds? clouds,
    @JsonKey(name: 'wind') Wind? wind,
    @JsonKey(name: 'visibility') int? visibility,
    @JsonKey(name: 'pop') double? pop,
    @JsonKey(name: 'rain') Rain? rain,
    @JsonKey(name: 'sys') Sys? sys,
    @JsonKey(name: 'dt_txt') String? dtTxt,
  }) = _Forecast;

  factory Forecast.fromJson(Map<String, Object?> json) =>
      _$ForecastFromJson(json);
}

@freezed
class City with _$City {
  factory City({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'coord') Coord? coord,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'population') int? population,
    @JsonKey(name: 'timezone') int? timezone,
    @JsonKey(name: 'sunrise') int? sunrise,
    @JsonKey(name: 'sunset') int? sunset,
  }) = _City;

  factory City.fromJson(Map<String, Object?> json) => _$CityFromJson(json);
}
