import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

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
        child: Lottie.asset('assets/lottie/loading_lottie.json'),
      ),
    );
  }
}
