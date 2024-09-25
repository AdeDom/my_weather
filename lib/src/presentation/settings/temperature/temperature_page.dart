import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/data/models/enum/app_temperature.dart';
import 'package:my_weather/src/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/src/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';
import 'package:my_weather/src/ui/common_widgets/bottom_sheet_item_widget.dart';

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
          BottomSheetItemWidget(
            title: LocaleKeys.temperature_celsius.tr(),
            isCheck: isTemperatureCelsius,
            onTap: () => _onSelectTemperature(AppTemperature.celsius),
          ),
          const Divider(),
          BottomSheetItemWidget(
            title: LocaleKeys.temperature_fahrenheit.tr(),
            isCheck: isTemperatureFahrenheit,
            onTap: () => _onSelectTemperature(AppTemperature.fahrenheit),
          ),
        ],
      ),
    );
  }

  void _onSelectTemperature(AppTemperature temperature) {
    final appSettingsRepository = ref.read(appSettingsRepositoryProvider);
    appSettingsRepository.setAppTemperature(temperature);

    ref.invalidate(getAppTemperatureProvider);
    ref.invalidate(fetchCurrentWeatherProvider);
    ref.invalidate(fetchForecastProvider);

    context.pop();
  }
}
