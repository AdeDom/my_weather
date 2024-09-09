import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: Sizes.p128,
            height: Sizes.p128,
            child: Lottie.asset('assets/lottie/empty_lottie.json'),
          ),
          Text(
            'Empty',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
