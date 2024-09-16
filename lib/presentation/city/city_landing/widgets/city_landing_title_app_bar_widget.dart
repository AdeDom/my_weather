import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/ui/common_widgets/app_loading_widget.dart';

class CityLandingTitleAppBarWidget extends ConsumerWidget {
  const CityLandingTitleAppBarWidget({
    super.key,
    required this.selectIds,
  });

  final List<String> selectIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(getGeographicalCoordinatesAllProvider);

    return result.when(
      data: (data) {
        final isSelectAll = selectIds.length == data.length;
        final isDeselectAll = selectIds.isEmpty;
        final countSelected = selectIds.length.toString();
        if (isSelectAll) {
          return Text(LocaleKeys.city_landing_all_selected.tr());
        } else if (!isDeselectAll) {
          return Text(
            LocaleKeys.city_landing_selected.tr(args: [countSelected]),
          );
        } else {
          return Text(LocaleKeys.city_landing_select_items.tr());
        }
      },
      error: (error, _) => ErrorWidget(error.toString()),
      loading: () => const AppLoadingWidget(),
    );
  }
}
