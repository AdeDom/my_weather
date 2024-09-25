import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_weather/src/data/models/enum/app_weather.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

@freezed
class WeatherResponse with _$WeatherResponse {
  factory WeatherResponse({
    int? id,
    @JsonKey(
      name: 'main',
      defaultValue: AppWeather.unknown,
      unknownEnumValue: AppWeather.unknown,
    )
    required AppWeather main,
    String? description,
    String? icon,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, Object?> json) =>
      _$WeatherResponseFromJson(json);
}
