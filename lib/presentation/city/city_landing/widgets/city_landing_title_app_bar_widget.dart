import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
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
        final countSelected = selectIds.length;
        if (isSelectAll) {
          return const Text('All selected');
        } else if (!isDeselectAll) {
          return Text('$countSelected Selected');
        } else {
          return const Text('Select items');
        }
      },
      error: (error, _) => ErrorWidget(error.toString()),
      loading: () => const AppLoadingWidget(),
    );
  }
}
