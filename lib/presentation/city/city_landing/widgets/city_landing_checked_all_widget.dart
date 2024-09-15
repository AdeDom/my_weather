import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/ui/common_widgets/app_loading_widget.dart';

class CityLandingCheckedAllWidget extends ConsumerWidget {
  const CityLandingCheckedAllWidget({
    super.key,
    required this.selectIds,
    required this.onCheckedAll,
  });

  final List<String> selectIds;
  final Function() onCheckedAll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(getGeographicalCoordinatesAllProvider);

    return result.when(
      data: (data) {
        final isCheckedAll = selectIds.length == data.length;
        return TextButton(
          onPressed: onCheckedAll,
          child: Text(isCheckedAll ? 'Deselect all' : 'Select all'),
        );
      },
      error: (error, _) => ErrorWidget(error.toString()),
      loading: () => const AppLoadingWidget(),
    );
  }
}
