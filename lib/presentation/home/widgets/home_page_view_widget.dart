import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/presentation/home/home_page.dart';
import 'package:my_weather/ui/common_widgets/app_empty_widget.dart';
import 'package:my_weather/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/ui/common_widgets/app_loading_widget.dart';

class HomePageViewWidget extends ConsumerWidget {
  const HomePageViewWidget({
    super.key,
    required this.onPageViewChanged,
  });

  final Function(int) onPageViewChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(getGeographicalCoordinatesAllProvider);

    return result.when(
      data: (data) {
        if (data.isEmpty) {
          return const AppEmptyWidget();
        }

        return PageView(
          onPageChanged: onPageViewChanged,
          children: data
              .map((element) => HomePage(geographicalCoordinates: element))
              .toList(),
        );
      },
      error: (error, _) => const AppErrorWidget(),
      loading: () => const AppLoadingWidget(),
    );
  }
}
