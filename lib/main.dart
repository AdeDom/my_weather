import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/data_source/local/providers/shared_preferences_provider.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/routing/app_router.dart';
import 'package:my_weather/ui/common_widgets/loading_screen.dart';
import 'package:my_weather/ui/theme/theme.dart';
import 'package:my_weather/ui/theme/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runApp(const LoadingScreen());

  final prefs = await SharedPreferences.getInstance();
  return runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(
      context,
      'IBM Plex Sans Thai',
      'IBM Plex Sans Thai',
    );

    final isDarkMode = ref.watch(isDarkModeProvider);

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Weather',
      theme: isDarkMode ? theme.dark() : theme.light(),
      routerConfig: appRouter,
    );
  }
}
