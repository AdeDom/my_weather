import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/data/models/enum/app_temperature.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/presentation/settings/settings/providers/settings_controller.dart';
import 'package:my_weather/presentation/settings/temperature/temperature_page.dart';
import 'package:my_weather/routing/app_router.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

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
          _buildThemeWidget(),
          _buildUnitsWidget(),
          _buildAboutWeatherWidget(),
        ],
      ),
    );
  }

  Widget _buildThemeWidget() {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return Padding(
      padding: const EdgeInsets.all(Sizes.p8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Sizes.p16, bottom: Sizes.p4),
            child: Row(
              children: [
                Text(
                  'Theme',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: Row(
                children: [
                  Text(
                    'Theme mode',
                    // 'Dark mode',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Switch(
                    value: isDarkMode,
                    onChanged: _onChangeTheme,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitsWidget() {
    final temperature = ref.watch(getAppTemperatureProvider);
    final isTemperatureCelsius = temperature == AppTemperature.celsius;
    return Padding(
      padding: const EdgeInsets.all(Sizes.p8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Sizes.p16, bottom: Sizes.p4),
            child: Row(
              children: [
                Text(
                  'Units',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: Column(
                children: [
                  _buildUnitItemWidget(
                    'Temperature',
                    isTemperatureCelsius ? 'Celsius (°C)' : 'Fahrenheit (°F)',
                    onTap: _showTemperatureBottomSheet,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitItemWidget(
    String name,
    String value, {
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutWeatherWidget() {
    return GestureDetector(
      onTap: _onOpenAboutWeather,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p8),
        child: Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'About Weather',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onChangeTheme(bool value) {
    ref.read(settingsControllerProvider.notifier).onChangeTheme(value);
  }

  void _showTemperatureBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => const TemperaturePage(),
    );
  }

  void _onOpenAboutWeather() {
    context.goNamed(AppRoute.aboutWeather.name);
  }
}
