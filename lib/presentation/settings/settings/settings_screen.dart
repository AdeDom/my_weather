import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/presentation/settings/settings/widgets/settings_about_weather_widget.dart';
import 'package:my_weather/presentation/settings/settings/widgets/settings_theme_widget.dart';
import 'package:my_weather/presentation/settings/settings/widgets/settings_units_widget.dart';
import 'package:my_weather/presentation/settings/temperature/temperature_page.dart';
import 'package:my_weather/router/enum/app_router_screen.dart';

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
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          SettingsThemeWidget(onChangeTheme: _onChangeTheme),
          SettingsUnitsWidget(
            onShowTemperatureBottomSheet: _onShowTemperatureBottomSheet,
          ),
          SettingsAboutWeatherWidget(onOpenAboutWeather: _onOpenAboutWeather),
        ],
      ),
    );
  }

  void _onChangeTheme(bool value) {
    ref.read(setDarkModeProvider(value));
    ref.invalidate(isDarkModeProvider);
  }

  void _onShowTemperatureBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => const TemperaturePage(),
    );
  }

  void _onOpenAboutWeather() {
    context.goNamed(AppRouteScreen.aboutWeather.name);
  }
}
