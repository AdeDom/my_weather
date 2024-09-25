import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/src/presentation/city/geographical_coordinates/providers/geographical_coordinates_page_controller.dart';
import 'package:my_weather/src/ui/common_widgets/app_empty_widget.dart';
import 'package:my_weather/src/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/src/ui/common_widgets/app_loading_widget.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

class GeographicalCoordinatesListWidget extends ConsumerWidget {
  const GeographicalCoordinatesListWidget({
    super.key,
    required this.onSelected,
  });

  final Function(GeographicalCoordinatesResponse) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  onTap: () => onSelected(item),
                  child: Text(
                    LocaleKeys.geographical_coordinates_name_state.tr(
                      args: [item.name.toString(), item.state.toString()],
                    ),
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
