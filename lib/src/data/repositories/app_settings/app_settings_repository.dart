import 'package:my_weather/src/data/data_source/local/providers/shared_preferences_provider.dart';
import 'package:my_weather/src/data/models/enum/app_temperature.dart';
import 'package:my_weather/src/utils/extensions/string_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_settings_repository.g.dart';

abstract class AppSettingsRepository {
  bool isDarkMode();

  void setDarkMode(bool isDarkMode);

  AppTemperature getAppTemperature();

  void setAppTemperature(AppTemperature temperature);
}

class AppSettingsRepositoryImpl extends AppSettingsRepository {
  AppSettingsRepositoryImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;
  static const _isDarkMode = 'is_dark_mode';
  static const _temperature = 'temperature';

  @override
  bool isDarkMode() {
    return sharedPreferences.getBool(_isDarkMode) ?? false;
  }

  @override
  void setDarkMode(bool isDarkMode) {
    sharedPreferences.setBool(_isDarkMode, isDarkMode);
  }

  @override
  AppTemperature getAppTemperature() {
    return sharedPreferences.getString(_temperature).fromValue;
  }

  @override
  void setAppTemperature(AppTemperature temperature) {
    sharedPreferences.setString(_temperature, temperature.value);
  }
}

@riverpod
AppSettingsRepository appSettingsRepository(AppSettingsRepositoryRef ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return AppSettingsRepositoryImpl(sharedPreferences: sharedPreferences);
}

@riverpod
bool isDarkMode(IsDarkModeRef ref) {
  final appSettingsRepository = ref.watch(appSettingsRepositoryProvider);
  return appSettingsRepository.isDarkMode();
}

@riverpod
AppTemperature getAppTemperature(GetAppTemperatureRef ref) {
  final appSettingsRepository = ref.watch(appSettingsRepositoryProvider);
  return appSettingsRepository.getAppTemperature();
}
