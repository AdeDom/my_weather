import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';

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
          data.isEmpty ? 'My Weather' : data[pageViewIndex].name,
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
      error: (error, _) => _buildDefaultTitleWidget(context),
      loading: () => _buildDefaultTitleWidget(context),
    );
  }

  Text _buildDefaultTitleWidget(BuildContext context) {
    return Text(
      'My Weather',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
