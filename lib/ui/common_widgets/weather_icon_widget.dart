import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/models/enum/app_weather.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

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
    const resource = 'assets/images/';
    switch (widget.weather) {
      case AppWeather.rain:
        return isDarkMode
            ? '${resource}ic_rainy_dark.png'
            : '${resource}ic_rainy_light.png';
      case AppWeather.snow:
        return isDarkMode
            ? '${resource}ic_snowy_dark.png'
            : '${resource}ic_snowy_light.png';
      case AppWeather.clouds:
        return isDarkMode
            ? '${resource}ic_cloudy_dark.png'
            : '${resource}ic_cloudy_light.png';
      case AppWeather.unknown:
        return null;
      case null:
        return null;
    }
  }
}
