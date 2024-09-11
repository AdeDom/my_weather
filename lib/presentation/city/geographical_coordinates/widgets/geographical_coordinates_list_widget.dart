import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/presentation/city/geographical_coordinates/providers/geographical_coordinates_page_controller.dart';
import 'package:my_weather/ui/common_widgets/app_empty_widget.dart';
import 'package:my_weather/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/ui/common_widgets/app_loading_widget.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class GeographicalCoordinatesListWidget extends ConsumerStatefulWidget {
  const GeographicalCoordinatesListWidget({
    super.key,
    required this.onSelected,
  });

  final Function(GeographicalCoordinatesResponse) onSelected;

  @override
  ConsumerState createState() => _GeographicalCoordinatesListWidgetState();
}

class _GeographicalCoordinatesListWidgetState
    extends ConsumerState<GeographicalCoordinatesListWidget> {
  @override
  Widget build(BuildContext context) {
    final result = ref.watch(geographicalCoordinatesPageControllerProvider);

    return result.when(
      data: (data) {
        if (data == null) {
          return Container();
        }

        if (data.isEmpty) {
          return const Center(
            child: AppEmptyWidget(),
          );
        }

        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.p16,
              vertical: Sizes.p8,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final item = data[index];
              return SizedBox(
                height: Sizes.p64,
                child: GestureDetector(
                  onTap: () => widget.onSelected(item),
                  child: Text(
                    '${item.name}, ${item.state}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              );
            },
          ),
        );
      },
      error: (error, _) => AppErrorWidget(message: error.toString()),
      loading: () => const AppLoadingWidget(),
    );
  }
}
