import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class SettingsThemeWidget extends ConsumerWidget {
  const SettingsThemeWidget({
    super.key,
    required this.onChangeTheme,
  });

  final Function(bool) onChangeTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return Padding(
      padding: const EdgeInsets.all(Sizes.p8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Sizes.p16, bottom: Sizes.p4),
            child: Row(
              children: [
                Text(
                  'Theme',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: Row(
                children: [
                  Text(
                    'Theme mode',
                    // 'Dark mode',
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
        ],
      ),
    );
  }
}
