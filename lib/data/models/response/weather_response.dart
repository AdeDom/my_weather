import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_weather/data/models/enum/app_weather.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

@freezed
class WeatherResponse with _$WeatherResponse {
  factory WeatherResponse({
    @JsonKey(name: 'id') int? id,
    @JsonKey(
      name: 'main',
      defaultValue: AppWeather.unknown,
      unknownEnumValue: AppWeather.unknown,
    )
    required AppWeather main,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'icon') String? icon,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, Object?> json) =>
      _$WeatherResponseFromJson(json);
}
