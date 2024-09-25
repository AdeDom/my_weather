import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/generated/codegen_loader.g.dart';
import 'package:my_weather/src/data/data_source/local/constants/database_constant.dart';
import 'package:my_weather/src/data/data_source/local/providers/database_providers.dart';
import 'package:my_weather/src/data/data_source/local/providers/shared_preferences_provider.dart';
import 'package:my_weather/src/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/src/presentation/settings/language/constants/locale_constant.dart';
import 'package:my_weather/src/router/providers/app_router_provider.dart';
import 'package:my_weather/src/ui/common_widgets/loading_screen.dart';
import 'package:my_weather/src/ui/theme/theme.dart';
import 'package:my_weather/src/ui/theme/typography/text_theme_util.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  runApp(const LoadingScreen());

  // localize
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // sqlite
  final database = await openDatabase(
    join(await getDatabasesPath(), DatabaseConstant.databaseName),
    version: 1,
    onCreate: (db, version) {
      return db.execute(DatabaseConstant.createTable);
    },
  );

  // shared pref
  final sharedPreferences = await SharedPreferences.getInstance();

  return runApp(
    EasyLocalization(
      supportedLocales: LocaleConstant.locales,
      path: LocaleConstant.path,
      fallbackLocale: LocaleConstant.thaiLocale,
      startLocale: LocaleConstant.thaiLocale,
      assetLoader: const CodegenLoader(),
      child: ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        child: const MainApp(),
      ),
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'My Weather',
      theme: ref.watch(isDarkModeProvider) ? theme.dark() : theme.light(),
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
