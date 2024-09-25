import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/generated/assets.gen.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    this.size = Sizes.p128,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Lottie.asset(Assets.lottie.loadingLottie),
      ),
    );
  }
}
