import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/generated/assets.gen.dart';
import 'package:my_weather/src/data/models/enum/app_weather.dart';
import 'package:my_weather/src/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

class WeatherIconWidget extends ConsumerStatefulWidget {
  const WeatherIconWidget({
    super.key,
    required this.weather,
  });

  final AppWeather? weather;

  @override
  ConsumerState createState() => _WeatherIconWidgetState();
}

class _WeatherIconWidgetState extends ConsumerState<WeatherIconWidget> {
  @override
  Widget build(BuildContext context) {
    final assetImage = _getAssetImage();
    if (assetImage != null) {
      return SizedBox(
        width: Sizes.p64,
        child: Image.asset(
          assetImage,
          fit: BoxFit.fill,
        ),
      );
    } else {
      return Container();
    }
  }

  String? _getAssetImage() {
    final isDarkMode = ref.watch(isDarkModeProvider);
    switch (widget.weather) {
      case AppWeather.rain:
        return isDarkMode
            ? Assets.images.icRainyDark.path
            : Assets.images.icRainyLight.path;
      case AppWeather.snow:
        return isDarkMode
            ? Assets.images.icSnowyDark.path
            : Assets.images.icSnowyLight.path;
      case AppWeather.clouds:
        return isDarkMode
            ? Assets.images.icCloudyDark.path
            : Assets.images.icCloudyLight.path;
      case AppWeather.unknown:
        return null;
      case null:
        return null;
    }
  }
}
