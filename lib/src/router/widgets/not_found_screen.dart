import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/generated/assets.gen.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/router/enum/app_router_screen.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

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
              child: Lottie.asset(Assets.lottie.emptyLottie),
            ),
            const SizedBox(height: Sizes.p32),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRouteScreen.home.name),
              child: Text(LocaleKeys.common_go_home.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
