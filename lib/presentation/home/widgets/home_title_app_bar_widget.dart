import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/generated/locale_keys.g.dart';

class HomeTitleAppBarWidget extends ConsumerWidget {
  const HomeTitleAppBarWidget({
    super.key,
    required this.pageViewIndex,
  });

  final int pageViewIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(getGeographicalCoordinatesAllProvider);

    return result.when(
      data: (data) {
        return Text(
          data.isEmpty
              ? LocaleKeys.common_app_name.tr()
              : data[pageViewIndex].name,
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
      error: (error, _) => _buildDefaultTitleWidget(context),
      loading: () => _buildDefaultTitleWidget(context),
    );
  }

  Text _buildDefaultTitleWidget(BuildContext context) {
    return Text(
      LocaleKeys.common_app_name.tr(),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
