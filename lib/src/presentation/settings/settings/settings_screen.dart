import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/src/presentation/settings/settings/widgets/settings_about_weather_widget.dart';
import 'package:my_weather/src/presentation/settings/settings/widgets/settings_language_widget.dart';
import 'package:my_weather/src/presentation/settings/settings/widgets/settings_temperature_widget.dart';
import 'package:my_weather/src/presentation/settings/settings/widgets/settings_theme_widget.dart';
import 'package:my_weather/src/router/enum/app_router_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(LocaleKeys.settings_settings.tr()),
      ),
      body: Column(
        children: [
          SettingsThemeWidget(
            isDarkMode: ref.watch(isDarkModeProvider),
            onChangeTheme: _onChangeTheme,
          ),
          const SettingsLanguageWidget(),
          SettingsTemperatureWidget(
            temperature: ref.watch(getAppTemperatureProvider),
          ),
          SettingsAboutWeatherWidget(onOpenAboutWeather: _onOpenAboutWeather),
        ],
      ),
    );
  }

  void _onChangeTheme(bool value) {
    final appSettingsRepository = ref.read(appSettingsRepositoryProvider);
    appSettingsRepository.setDarkMode(value);

    ref.invalidate(isDarkModeProvider);
  }

  void _onOpenAboutWeather() {
    context.goNamed(AppRouteScreen.aboutWeather.name);
  }
}
