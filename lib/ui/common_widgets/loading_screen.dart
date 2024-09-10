import 'package:flutter/material.dart';
import 'package:my_weather/ui/theme/theme.dart';
import 'package:my_weather/ui/theme/util.dart';

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
      title: 'My Weather',
      theme: theme.light(),
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
