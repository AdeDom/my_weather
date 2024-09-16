import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';
import 'package:my_weather/ui/common_widgets/bottom_sheet_item_widget.dart';
import 'package:my_weather/utils/constants/app_constant.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p32),
      child: Column(
        children: [
          BottomSheetItemWidget(
            title: LocaleKeys.common_thai.tr(),
            isCheck: context.locale == AppConstant.thaiLocale,
            onTap: () => _onSetLocale(context, AppConstant.thaiLocale),
          ),
          const Divider(),
          BottomSheetItemWidget(
            title: LocaleKeys.common_english.tr(),
            isCheck: context.locale == AppConstant.englishLocale,
            onTap: () => _onSetLocale(context, AppConstant.englishLocale),
          ),
        ],
      ),
    );
  }

  void _onSetLocale(BuildContext context, Locale locale) {
    context.setLocale(locale);
    context.pop();
  }
}
