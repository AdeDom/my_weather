import 'package:go_router/go_router.dart';
import 'package:my_weather/presentation/city/city_landing/city_landing_screen.dart';
import 'package:my_weather/presentation/forecast/forecast_screen.dart';
import 'package:my_weather/presentation/forecast/models/forecast_argument.dart';
import 'package:my_weather/presentation/home/home_screen.dart';
import 'package:my_weather/presentation/settings/about_weather/about_weather_screen.dart';
import 'package:my_weather/presentation/settings/settings/settings_screen.dart';
import 'package:my_weather/routing/not_found_screen.dart';

enum AppRoute {
  home,
  forecast,
  cityLanding,
  settings,
  aboutWeather;
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: AppRoute.forecast.name,
          name: AppRoute.forecast.name,
          builder: (context, state) {
            final args = state.extra as ForecastArgument;
            return ForecastScreen(args: args);
          },
        ),
        GoRoute(
          path: AppRoute.cityLanding.name,
          name: AppRoute.cityLanding.name,
          builder: (context, state) => const CityLandingScreen(),
        ),
        GoRoute(
          path: AppRoute.settings.name,
          name: AppRoute.settings.name,
          builder: (context, state) => const SettingsScreen(),
          routes: [
            GoRoute(
              path: AppRoute.aboutWeather.name,
              name: AppRoute.aboutWeather.name,
              builder: (context, state) => const AboutWeatherScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
