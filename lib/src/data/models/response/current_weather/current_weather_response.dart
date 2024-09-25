import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_weather/src/data/models/response/clouds_response.dart';
import 'package:my_weather/src/data/models/response/coord_response.dart';
import 'package:my_weather/src/data/models/response/main_response.dart';
import 'package:my_weather/src/data/models/response/rain_response.dart';
import 'package:my_weather/src/data/models/response/sys_response.dart';
import 'package:my_weather/src/data/models/response/weather_response.dart';
import 'package:my_weather/src/data/models/response/wind_response.dart';

part 'current_weather_response.freezed.dart';
part 'current_weather_response.g.dart';

@freezed
class CurrentWeatherResponse with _$CurrentWeatherResponse {
  factory CurrentWeatherResponse({
    CoordResponse? coord,
    List<WeatherResponse>? weather,
    String? base,
    MainResponse? main,
    int? visibility,
    WindResponse? wind,
    CloudsResponse? clouds,
    RainResponse? rain,
    int? dt,
    SysResponse? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) = _CurrentWeatherResponse;

  factory CurrentWeatherResponse.fromJson(Map<String, Object?> json) =>
      _$CurrentWeatherResponseFromJson(json);
}
