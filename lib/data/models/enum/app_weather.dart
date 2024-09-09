import 'package:json_annotation/json_annotation.dart';

enum AppWeather {
  @JsonValue('Rain')
  rain('Rain'),
  @JsonValue('Snow')
  snow('Snow'),
  @JsonValue('Clouds')
  clouds('Clouds'),
  @JsonValue('Unknown')
  unknown('Unknown');

  const AppWeather(this.value);

  final String value;
}
