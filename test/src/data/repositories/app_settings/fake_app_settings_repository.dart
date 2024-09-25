import 'package:my_weather/src/data/models/enum/app_temperature.dart';
import 'package:my_weather/src/data/repositories/app_settings/app_settings_repository.dart';

class FakeAppSettingsRepository extends AppSettingsRepository {
  var _isDarkMode = false;
  var _temperature = AppTemperature.celsius;

  @override
  bool isDarkMode() {
    return _isDarkMode;
  }

  @override
  void setDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
  }

  @override
  AppTemperature getAppTemperature() {
    return _temperature;
  }

  @override
  void setAppTemperature(AppTemperature temperature) {
    _temperature = temperature;
  }
}
