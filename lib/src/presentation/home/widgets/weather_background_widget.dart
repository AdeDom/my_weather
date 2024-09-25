import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/generated/assets.gen.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/data/models/enum/app_weather.dart';
import 'package:my_weather/src/data/models/response/current_weather/current_weather_response.dart';
import 'package:my_weather/src/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/src/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/src/ui/common_widgets/app_error_widget.dart';

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

    if (lat == null || lon == null) {
      return AppErrorWidget(
        message: LocaleKeys.common_something_went_wrong.tr(),
      );
    }

    final result = ref.watch(fetchCurrentWeatherProvider(lat: lat, lon: lon));

    return result.when(
      data: (data) => _buildBackgroundWidget(data),
      error: (error, _) => const AppErrorWidget(),
      loading: () => Container(),
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
    switch (weatherFirst?.main) {
      case AppWeather.rain:
        return isDarkMode
            ? Assets.images.imgRainyDark.path
            : Assets.images.imgRainyLight.path;
      case AppWeather.snow:
        return isDarkMode
            ? Assets.images.imgSnowyDark.path
            : Assets.images.imgSnowyLight.path;
      case AppWeather.clouds:
        return isDarkMode
            ? Assets.images.imgCloudyDark.path
            : Assets.images.imgCloudyLight.path;
      case AppWeather.unknown:
        return null;
      case null:
        return null;
    }
  }
}
