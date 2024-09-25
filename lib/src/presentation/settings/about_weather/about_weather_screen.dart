import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

class AboutWeatherScreen extends ConsumerStatefulWidget {
  const AboutWeatherScreen({super.key});

  @override
  ConsumerState createState() => _AboutWeatherScreenState();
}

class _AboutWeatherScreenState extends ConsumerState<AboutWeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(LocaleKeys.about_weather_about_weather.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.company_name.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              LocaleKeys.company_address.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
