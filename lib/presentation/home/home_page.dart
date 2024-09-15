import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';
import 'package:my_weather/presentation/forecast/models/forecast_argument.dart';
import 'package:my_weather/presentation/home/widgets/current_weather_widget.dart';
import 'package:my_weather/presentation/home/widgets/home_forecast_widget.dart';
import 'package:my_weather/presentation/home/widgets/weather_background_widget.dart';
import 'package:my_weather/router/enum/app_router_screen.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    required this.geographicalCoordinates,
  });

  final GeographicalCoordinatesEntity geographicalCoordinates;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final lat = widget.geographicalCoordinates.lat;
    final lon = widget.geographicalCoordinates.lon;
    return Stack(
      children: [
        WeatherBackgroundWidget(lat: lat, lon: lon),
        Column(
          children: [
            CurrentWeatherWidget(lat: lat, lon: lon),
            HomeForecastWidget(lat: lat, lon: lon),
            _buildSeeMoreWidget(),
          ],
        ),
      ],
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
      lat: widget.geographicalCoordinates.lat,
      lon: widget.geographicalCoordinates.lon,
    );
    context.goNamed(
      AppRouteScreen.forecast.name,
      extra: extra,
    );
  }
}
