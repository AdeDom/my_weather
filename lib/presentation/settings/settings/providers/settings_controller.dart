import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  @override
  void build() {}

  void onChangeTheme(bool value) {
    ref.read(setDarkModeProvider(value));
    ref.invalidate(isDarkModeProvider);
  }
}
