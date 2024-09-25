import 'package:go_router/go_router.dart';
import 'package:my_weather/src/presentation/city/city_landing/city_landing_screen.dart';
import 'package:my_weather/src/presentation/forecast/forecast_screen.dart';
import 'package:my_weather/src/presentation/forecast/models/forecast_argument.dart';
import 'package:my_weather/src/presentation/home/home_screen.dart';
import 'package:my_weather/src/presentation/settings/about_weather/about_weather_screen.dart';
import 'package:my_weather/src/presentation/settings/settings/settings_screen.dart';
import 'package:my_weather/src/router/enum/app_router_screen.dart';
import 'package:my_weather/src/router/widgets/not_found_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router_provider.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRouteScreen.home.name,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: AppRouteScreen.forecast.name,
            name: AppRouteScreen.forecast.name,
            builder: (context, state) {
              final args = state.extra as ForecastArgument;
              return ForecastScreen(args: args);
            },
          ),
          GoRoute(
            path: AppRouteScreen.cityLanding.name,
            name: AppRouteScreen.cityLanding.name,
            builder: (context, state) => const CityLandingScreen(),
          ),
          GoRoute(
            path: AppRouteScreen.settings.name,
            name: AppRouteScreen.settings.name,
            builder: (context, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: AppRouteScreen.aboutWeather.name,
                name: AppRouteScreen.aboutWeather.name,
                builder: (context, state) => const AboutWeatherScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
