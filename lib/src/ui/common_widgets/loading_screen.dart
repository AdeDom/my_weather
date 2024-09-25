import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/ui/theme/theme.dart';
import 'package:my_weather/src/ui/theme/typography/text_theme_util.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(
      context,
      'IBM Plex Sans Thai',
      'IBM Plex Sans Thai',
    );

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: LocaleKeys.common_app_name.tr(),
      theme: theme.light(),
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
