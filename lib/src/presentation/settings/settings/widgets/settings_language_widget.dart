import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/presentation/settings/language/constants/locale_constant.dart';
import 'package:my_weather/src/presentation/settings/language/language_page.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

class SettingsLanguageWidget extends StatelessWidget {
  const SettingsLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p8),
      child: GestureDetector(
        onTap: () => _onShowLanguageBottomSheet(context),
        child: Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Row(
              children: [
                Text(
                  LocaleKeys.language_language.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Text(
                  context.locale == LocaleConstant.thaiLocale
                      ? LocaleKeys.common_thai
                      : LocaleKeys.common_english,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onShowLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => const LanguagePage(),
    );
  }
}
