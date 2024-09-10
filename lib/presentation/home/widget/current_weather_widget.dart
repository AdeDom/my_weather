import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/models/response/current_weather/current_weather_response.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/ui/common_widgets/app_loading_widget.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';
import 'package:my_weather/ui/common_widgets/weather_icon_widget.dart';
import 'package:my_weather/utils/extensions/double_extensions.dart';

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
    final result = ref.watch(fetchCurrentWeatherProvider(lat: lat, lon: lon));

    return result.when(
      data: (data) => _buildCurrentWeatherWidget(data),
      error: (error, _) => const AppErrorWidget(size: Sizes.p64),
      loading: () => const AppLoadingWidget(size: Sizes.p64),
    );
  }

  Padding _buildCurrentWeatherWidget(CurrentWeatherResponse data) {
    final width = MediaQuery.sizeOf(context).width;
    final weatherFirst = data.weather?.firstOrNull;
    final temp = data.main?.temp?.toInt();
    final tempMin = data.main?.tempMin?.temperature;
    final tempMax = data.main?.tempMax?.temperature;
    final tempMinMax = '$tempMin°/$tempMax°';
    final humidity = data.main?.humidity;
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
                      '$temp°',
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
                _buildTextWidget(tempMinMax),
                const SizedBox(height: Sizes.p16),
                _buildTextWidget('Humidity $humidity'),
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
