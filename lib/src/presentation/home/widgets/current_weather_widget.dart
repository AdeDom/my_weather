import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/data/models/response/current_weather/current_weather_response.dart';
import 'package:my_weather/src/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/src/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';
import 'package:my_weather/src/ui/common_widgets/weather_icon_widget.dart';
import 'package:my_weather/src/utils/extensions/double_extensions.dart';

class CurrentWeatherWidget extends ConsumerStatefulWidget {
  const CurrentWeatherWidget({
    super.key,
    required this.lat,
    required this.lon,
  });

  final double? lat;
  final double? lon;

  @override
  ConsumerState createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends ConsumerState<CurrentWeatherWidget> {
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
      data: (data) => _buildCurrentWeatherWidget(data),
      error: (error, _) => const AppErrorWidget(size: Sizes.p64),
      loading: () => _buildCurrentWeatherWidget(null),
    );
  }

  Padding _buildCurrentWeatherWidget(CurrentWeatherResponse? data) {
    final width = MediaQuery.sizeOf(context).width;
    final weatherFirst = data?.weather?.firstOrNull;
    final temp = data?.main?.temp?.toInt().toString() ?? '?';
    final tempMin = data?.main?.tempMin?.temperature ?? '?';
    final tempMax = data?.main?.tempMax?.temperature ?? '?';
    final humidity = data?.main?.humidity.toString() ?? '?';
    return Padding(
      padding: const EdgeInsets.only(
        left: Sizes.p16,
        top: Sizes.p128,
        right: Sizes.p16,
      ),
      child: SizedBox(
        width: width,
        child: Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p32),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WeatherIconWidget(weather: weatherFirst?.main),
                    const SizedBox(width: Sizes.p16),
                    Text(
                      LocaleKeys.common_temp.tr(args: [temp]),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.p16),
                _buildTextWidget(weatherFirst?.main.value),
                const SizedBox(height: Sizes.p16),
                _buildTextWidget(weatherFirst?.description),
                const SizedBox(height: Sizes.p16),
                _buildTextWidget(
                  LocaleKeys.common_temp_min_max.tr(args: [tempMin, tempMax]),
                ),
                const SizedBox(height: Sizes.p16),
                _buildTextWidget(
                  LocaleKeys.home_humidity.tr(args: [humidity]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _buildTextWidget(String? text) {
    return Text(
      text ?? '',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
      textAlign: TextAlign.center,
    );
  }
}
