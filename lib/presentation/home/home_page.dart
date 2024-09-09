import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/domain/models/home/geocoding_model.dart';
import 'package:my_weather/domain/models/home/home_forecast_model.dart';
import 'package:my_weather/presentation/forecast/models/forecast_argument.dart';
import 'package:my_weather/presentation/home/weather_background_widget.dart';
import 'package:my_weather/routing/app_router.dart';
import 'package:my_weather/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/ui/common_widgets/app_loading_widget.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';
import 'package:my_weather/ui/common_widgets/weather_icon_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    required this.geocoding,
  });

  final GeocodingModel geocoding;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final lat = widget.geocoding.lat;
    final lon = widget.geocoding.lon;
    return Stack(
      children: [
        WeatherBackgroundWidget(lat: lat, lon: lon),
        Column(
          children: [
            _buildTemperatureWidget(),
            _buildForecastWidget(),
            _buildSeeMoreWidget(),
          ],
        ),
      ],
    );
  }

  Widget _buildTemperatureWidget() {
    final width = MediaQuery.sizeOf(context).width;
    final lat = widget.geocoding.lat;
    final lon = widget.geocoding.lon;
    final result = ref.watch(fetchCurrentWeatherProvider(lat: lat, lon: lon));

    return result.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.only(
            left: Sizes.p16,
            top: Sizes.p80,
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
                        WeatherIconWidget(weather: data.weather),
                        const SizedBox(width: Sizes.p16),
                        Text(
                          '${data.temp}°',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Sizes.p16),
                    Text(
                      data.weather.value,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Sizes.p16),
                    Text(
                      data.description,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Sizes.p16),
                    Text(
                      data.tempMinMax,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: Sizes.p16),
                    Text(
                      'Humidity ${data.humidity}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      error: (error, _) => const AppErrorWidget(size: Sizes.p64),
      loading: () => const AppLoadingWidget(size: Sizes.p64),
    );
  }

  Widget _buildForecastWidget() {
    final lat = widget.geocoding.lat;
    final lon = widget.geocoding.lon;
    final result = ref.watch(fetchHomeForecastProvider(lat: lat, lon: lon));

    return result.when(
      data: (data) {
        return SizedBox(
          height: Sizes.p128,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.p16,
              top: Sizes.p16,
              right: Sizes.p16,
            ),
            child: Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildForecastItemWidget(data[index]);
                },
              ),
            ),
          ),
        );
      },
      error: (error, _) => const AppErrorWidget(size: Sizes.p64),
      loading: () => const AppLoadingWidget(size: Sizes.p64),
    );
  }

  Widget _buildForecastItemWidget(HomeForecastModel data) {
    return Padding(
      padding: const EdgeInsets.only(left: Sizes.p24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.time,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Icon(
              Icons.cloud,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              '${data.temp}°',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeeMoreWidget() {
    return TextButton(
      onPressed: _onOpenForecast,
      child: Text(
        'See more',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              decoration: TextDecoration.underline,
            ),
      ),
    );
  }

  void _onOpenForecast() {
    final extra = ForecastArgument(
      lat: widget.geocoding.lat,
      lon: widget.geocoding.lon,
    );
    context.goNamed(
      AppRoute.forecast.name,
      extra: extra,
    );
  }
}
