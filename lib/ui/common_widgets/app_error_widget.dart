import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    this.message,
    this.size = Sizes.p128,
  });

  final String? message;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: Lottie.asset('assets/lottie/error_lottie.json'),
          ),
          if (message != null) ...[
            Text(
              message!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ],
      ),
    );
  }
}
