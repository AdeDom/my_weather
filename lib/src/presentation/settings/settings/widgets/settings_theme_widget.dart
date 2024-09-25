import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

class SettingsThemeWidget extends StatelessWidget {
  const SettingsThemeWidget({
    super.key,
    required this.isDarkMode,
    required this.onChangeTheme,
  });

  final bool isDarkMode;
  final Function(bool) onChangeTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p8),
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Row(
            children: [
              Text(
                LocaleKeys.theme_theme_mode.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: onChangeTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
