import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/models/enum/app_weather.dart';
import 'package:my_weather/data/models/response/current_weather/current_weather_response.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/ui/common_widgets/app_loading_widget.dart';

class WeatherBackgroundWidget extends ConsumerStatefulWidget {
  const WeatherBackgroundWidget({
    super.key,
    required this.lat,
    required this.lon,
  });

  final double? lat;
  final double? lon;

  @override
  ConsumerState createState() => _WeatherBackgroundWidgetState();
}

class _WeatherBackgroundWidgetState
    extends ConsumerState<WeatherBackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    final lat = widget.lat;
    final lon = widget.lon;
    final result = ref.watch(fetchCurrentWeatherProvider(lat: lat, lon: lon));
    return result.when(
      data: (data) => _buildBackgroundWidget(data),
      error: (error, _) => const AppErrorWidget(),
      loading: () => const AppLoadingWidget(),
    );
  }

  Widget _buildBackgroundWidget(CurrentWeatherResponse data) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final assetImage = _getAssetImage(data);
    if (assetImage != null) {
      return Image.asset(
        assetImage,
        fit: BoxFit.fill,
        width: width,
        height: height,
      );
    } else {
      return Container();
    }
  }

  String? _getAssetImage(CurrentWeatherResponse data) {
    final weatherFirst = data.weather?.firstOrNull;
    final isDarkMode = ref.watch(isDarkModeProvider);
    const resource = 'assets/images/';
    switch (weatherFirst?.main) {
      case AppWeather.rain:
        return isDarkMode
            ? '${resource}img_rainy_dark.png'
            : '${resource}img_rainy_light.png';
      case AppWeather.snow:
        return isDarkMode
            ? '${resource}img_snowy_dark.png'
            : '${resource}img_snowy_light.png';
      case AppWeather.clouds:
        return isDarkMode
            ? '${resource}img_cloudy_dark.png'
            : '${resource}img_cloudy_light.png';
      case AppWeather.unknown:
        return null;
      case null:
        return null;
    }
  }
}
