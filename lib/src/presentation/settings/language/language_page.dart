import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/presentation/settings/language/constants/locale_constant.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';
import 'package:my_weather/src/ui/common_widgets/bottom_sheet_item_widget.dart';

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
            isCheck: context.locale == LocaleConstant.thaiLocale,
            onTap: () => _onSetLocale(context, LocaleConstant.thaiLocale),
          ),
          const Divider(),
          BottomSheetItemWidget(
            title: LocaleKeys.common_english.tr(),
            isCheck: context.locale == LocaleConstant.englishLocale,
            onTap: () => _onSetLocale(context, LocaleConstant.englishLocale),
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
