import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/models/enum/app_temperature.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class SettingsUnitsWidget extends ConsumerStatefulWidget {
  const SettingsUnitsWidget({
    super.key,
    required this.onShowTemperatureBottomSheet,
  });

  final Function() onShowTemperatureBottomSheet;

  @override
  ConsumerState createState() => _SettingsUnitsWidgetState();
}

class _SettingsUnitsWidgetState extends ConsumerState<SettingsUnitsWidget> {
  @override
  Widget build(BuildContext context) {
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
                    onTap: widget.onShowTemperatureBottomSheet,
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
}
