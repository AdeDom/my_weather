import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/routing/app_router.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Sizes.p128,
              height: Sizes.p128,
              child: Lottie.asset('assets/lottie/empty_lottie.json'),
            ),
            const SizedBox(height: Sizes.p32),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoute.home.name),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
