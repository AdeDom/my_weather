import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_weather/data/models/response/clouds_response.dart';
import 'package:my_weather/data/models/response/coord_response.dart';
import 'package:my_weather/data/models/response/main_response.dart';
import 'package:my_weather/data/models/response/rain_response.dart';
import 'package:my_weather/data/models/response/sys_response.dart';
import 'package:my_weather/data/models/response/weather_response.dart';
import 'package:my_weather/data/models/response/wind_response.dart';

part 'forecast_response.freezed.dart';
part 'forecast_response.g.dart';

@freezed
class ForecastResponse with _$ForecastResponse {
  factory ForecastResponse({
    @JsonKey(name: 'cod') String? cod,
    @JsonKey(name: 'message') int? message,
    @JsonKey(name: 'cnt') int? cnt,
    @JsonKey(name: 'list') List<ForecastItemResponse>? list,
    @JsonKey(name: 'city') CityResponse? city,
  }) = _ForecastResponse;

  factory ForecastResponse.fromJson(Map<String, Object?> json) =>
      _$ForecastResponseFromJson(json);
}

@freezed
class ForecastItemResponse with _$ForecastItemResponse {
  factory ForecastItemResponse({
    @JsonKey(name: 'dt') int? dt,
    @JsonKey(name: 'main') MainResponse? main,
    @JsonKey(name: 'weather') List<WeatherResponse>? weather,
    @JsonKey(name: 'clouds') CloudsResponse? clouds,
    @JsonKey(name: 'wind') WindResponse? wind,
    @JsonKey(name: 'visibility') int? visibility,
    @JsonKey(name: 'pop') double? pop,
    @JsonKey(name: 'rain') RainResponse? rain,
    @JsonKey(name: 'sys') SysResponse? sys,
    @JsonKey(name: 'dt_txt') String? dtTxt,
  }) = _ForecastItemResponse;

  factory ForecastItemResponse.fromJson(Map<String, Object?> json) =>
      _$ForecastItemResponseFromJson(json);
}

@freezed
class CityResponse with _$CityResponse {
  factory CityResponse({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'coord') CoordResponse? coord,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'population') int? population,
    @JsonKey(name: 'timezone') int? timezone,
    @JsonKey(name: 'sunrise') int? sunrise,
    @JsonKey(name: 'sunset') int? sunset,
  }) = _CityResponse;

  factory CityResponse.fromJson(Map<String, Object?> json) =>
      _$CityResponseFromJson(json);
}
