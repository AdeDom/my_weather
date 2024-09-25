import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_weather/src/data/models/response/clouds_response.dart';
import 'package:my_weather/src/data/models/response/coord_response.dart';
import 'package:my_weather/src/data/models/response/main_response.dart';
import 'package:my_weather/src/data/models/response/rain_response.dart';
import 'package:my_weather/src/data/models/response/sys_response.dart';
import 'package:my_weather/src/data/models/response/weather_response.dart';
import 'package:my_weather/src/data/models/response/wind_response.dart';

part 'forecast_response.freezed.dart';
part 'forecast_response.g.dart';

@freezed
class ForecastResponse with _$ForecastResponse {
  factory ForecastResponse({
    String? cod,
    int? message,
    int? cnt,
    List<ForecastItemResponse>? list,
    CityResponse? city,
  }) = _ForecastResponse;

  factory ForecastResponse.fromJson(Map<String, Object?> json) =>
      _$ForecastResponseFromJson(json);
}

@freezed
class ForecastItemResponse with _$ForecastItemResponse {
  factory ForecastItemResponse({
    int? dt,
    MainResponse? main,
    List<WeatherResponse>? weather,
    CloudsResponse? clouds,
    WindResponse? wind,
    int? visibility,
    double? pop,
    RainResponse? rain,
    SysResponse? sys,
    @JsonKey(name: 'dt_txt') String? dtTxt,
  }) = _ForecastItemResponse;

  factory ForecastItemResponse.fromJson(Map<String, Object?> json) =>
      _$ForecastItemResponseFromJson(json);
}

@freezed
class CityResponse with _$CityResponse {
  factory CityResponse({
    int? id,
    String? name,
    CoordResponse? coord,
    String? country,
    int? population,
    int? timezone,
    int? sunrise,
    int? sunset,
  }) = _CityResponse;

  factory CityResponse.fromJson(Map<String, Object?> json) =>
      _$CityResponseFromJson(json);
}
