import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/data/models/enum/app_temperature.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class TemperaturePage extends ConsumerStatefulWidget {
  const TemperaturePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TemperaturePageState();
}

class _TemperaturePageState extends ConsumerState<TemperaturePage> {
  @override
  Widget build(BuildContext context) {
    final temperature = ref.watch(getAppTemperatureProvider);
    final isTemperatureCelsius = temperature == AppTemperature.celsius;
    final isTemperatureFahrenheit = temperature == AppTemperature.fahrenheit;
    return Padding(
      padding: const EdgeInsets.all(Sizes.p32),
      child: Column(
        children: [
          _buildTemperatureItemWidget(
            'Celsius (°C)',
            isTemperatureCelsius,
            onTap: () => _onSelectTemperature(AppTemperature.celsius),
          ),
          const Divider(),
          _buildTemperatureItemWidget(
            'Fahrenheit (°F)',
            isTemperatureFahrenheit,
            onTap: () => _onSelectTemperature(AppTemperature.fahrenheit),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureItemWidget(
    String title,
    bool isCheck, {
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: isCheck ? Theme.of(context).colorScheme.primary : null,
                ),
          ),
          const Spacer(),
          if (isCheck) ...[
            Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ],
      ),
    );
  }

  void _onSelectTemperature(AppTemperature temperature) {
    ref.read(setAppTemperatureProvider(temperature));
    ref.invalidate(getAppTemperatureProvider);
    context.pop();
  }
}
