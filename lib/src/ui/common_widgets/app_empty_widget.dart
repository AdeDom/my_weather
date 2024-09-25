import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/generated/assets.gen.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

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
            child: Lottie.asset(Assets.lottie.emptyLottie),
          ),
          Text(
            LocaleKeys.common_data_not_found.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
