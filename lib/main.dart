import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/data_source/local/providers/database_providers.dart';
import 'package:my_weather/data/data_source/local/providers/shared_preferences_provider.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/ui/common_widgets/loading_screen.dart';
import 'package:my_weather/ui/theme/theme.dart';
import 'package:my_weather/ui/theme/util.dart';
import 'package:my_weather/utils/constants/app_constant.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'router/providers/app_router_provider.dart';

Future<void> main() async {
  runApp(const LoadingScreen());

  // sqlite
  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
    join(await getDatabasesPath(), AppConstant.databaseName),
    version: 1,
    onCreate: (db, version) {
      return db.execute(AppConstant.createTable);
    },
  );

  // shared pref
  final sharedPreferences = await SharedPreferences.getInstance();

  return runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
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
      'IBM Plex Sans Thai Looped',
      'IBM Plex Sans Thai',
    );

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Weather',
      theme: ref.watch(isDarkModeProvider) ? theme.dark() : theme.light(),
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
