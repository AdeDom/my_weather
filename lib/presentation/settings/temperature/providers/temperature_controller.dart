import 'package:my_weather/data/models/enum/app_temperature.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'temperature_controller.g.dart';

@riverpod
class TemperatureController extends _$TemperatureController {
  @override
  void build() {}

  void onSelectTemperature(AppTemperature temperature) {
    ref.read(setAppTemperatureProvider(temperature));
    ref.invalidate(getAppTemperatureProvider);
  }
}
