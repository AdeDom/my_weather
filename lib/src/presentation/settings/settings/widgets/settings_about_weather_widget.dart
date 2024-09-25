import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

class SettingsAboutWeatherWidget extends StatelessWidget {
  const SettingsAboutWeatherWidget({
    super.key,
    required this.onOpenAboutWeather,
  });

  final Function() onOpenAboutWeather;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpenAboutWeather,
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
                      LocaleKeys.about_weather_about_weather.tr(),
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
}
