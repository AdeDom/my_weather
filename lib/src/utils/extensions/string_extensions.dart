import 'package:my_weather/src/data/models/enum/app_temperature.dart';

extension AppTemperatureExtensions on String? {
  AppTemperature get fromValue {
    return AppTemperature.values
            .where((element) => element.value == this)
            .firstOrNull ??
        AppTemperature.celsius;
  }
}
