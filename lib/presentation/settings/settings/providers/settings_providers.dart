import 'package:my_weather/data/models/enum/app_temperature.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_providers.g.dart';

@riverpod
bool isTemperatureCelsius(IsTemperatureCelsiusRef ref) {
  return ref.watch(getAppTemperatureProvider) == AppTemperature.celsius;
}

@riverpod
bool isTemperatureFahrenheit(IsTemperatureFahrenheitRef ref) {
  return ref.watch(getAppTemperatureProvider) == AppTemperature.fahrenheit;
}
