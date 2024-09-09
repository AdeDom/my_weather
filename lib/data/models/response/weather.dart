import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_weather/data/models/enum/app_weather.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
class Weather with _$Weather {
  factory Weather({
    @JsonKey(name: 'id') int? id,
    @JsonKey(
      name: 'main',
      defaultValue: AppWeather.unknown,
      unknownEnumValue: AppWeather.unknown,
    )
    required AppWeather main,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'icon') String? icon,
  }) = _Weather;

  factory Weather.fromJson(Map<String, Object?> json) =>
      _$WeatherFromJson(json);
}
