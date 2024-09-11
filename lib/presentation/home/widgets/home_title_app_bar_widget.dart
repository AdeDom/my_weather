import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';

class HomeTitleAppBarWidget extends ConsumerStatefulWidget {
  const HomeTitleAppBarWidget({
    super.key,
    required this.pageViewIndex,
  });

  final int pageViewIndex;

  @override
  ConsumerState createState() => _HomeTitleAppBarWidgetState();
}

class _HomeTitleAppBarWidgetState extends ConsumerState<HomeTitleAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    final result = ref.watch(getGeographicalCoordinatesAllProvider);

    return result.when(
      data: (data) {
        return Text(
          data.isEmpty ? 'My Weather' : data[widget.pageViewIndex].name,
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
      error: (error, _) => Text(
        'My Weather',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      loading: () => Text(
        'My Weather',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
