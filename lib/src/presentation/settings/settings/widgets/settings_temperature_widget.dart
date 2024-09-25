import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/data/models/enum/app_temperature.dart';
import 'package:my_weather/src/presentation/settings/temperature/temperature_page.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

class SettingsTemperatureWidget extends StatelessWidget {
  const SettingsTemperatureWidget({
    super.key,
    required this.temperature,
  });

  final AppTemperature temperature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p8),
      child: GestureDetector(
        onTap: () => _onShowTemperatureBottomSheet(context),
        child: Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Row(
              children: [
                Text(
                  LocaleKeys.temperature_temperature.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Text(
                  temperature == AppTemperature.celsius
                      ? LocaleKeys.temperature_celsius.tr()
                      : LocaleKeys.temperature_fahrenheit.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onShowTemperatureBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => const TemperaturePage(),
    );
  }
}
