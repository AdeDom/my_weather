import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/data/models/response/forecast/forecast_response.dart';
import 'package:my_weather/src/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/src/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/src/ui/common_widgets/app_loading_widget.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';
import 'package:my_weather/src/utils/enum/date_time_format.dart';
import 'package:my_weather/src/utils/extensions/int_extensions.dart';

class HomeForecastWidget extends ConsumerStatefulWidget {
  const HomeForecastWidget({
    super.key,
    required this.lat,
    required this.lon,
  });

  final double? lat;
  final double? lon;

  @override
  ConsumerState createState() => _HomeForecastWidgetState();
}

class _HomeForecastWidgetState extends ConsumerState<HomeForecastWidget> {
  @override
  Widget build(BuildContext context) {
    final lat = widget.lat;
    final lon = widget.lon;

    if (lat == null || lon == null) {
      return AppErrorWidget(
        message: LocaleKeys.common_something_went_wrong.tr(),
      );
    }

    final result = ref.watch(fetchForecastProvider(lat: lat, lon: lon));

    return result.when(
      data: (data) => _buildForecastWidget(data),
      error: (error, _) => const AppErrorWidget(size: Sizes.p64),
      loading: () => const AppLoadingWidget(size: Sizes.p64),
    );
  }

  Widget _buildForecastWidget(List<ForecastItemResponse> data) {
    return SizedBox(
      height: Sizes.p128,
      child: Padding(
        padding: const EdgeInsets.only(
          left: Sizes.p16,
          top: Sizes.p16,
          right: Sizes.p16,
        ),
        child: Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildForecastItemWidget(data[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForecastItemWidget(ForecastItemResponse forecast) {
    return Padding(
      padding: const EdgeInsets.only(left: Sizes.p24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              forecast.dt?.convertDateTime(DateTimeFormat.time) ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Icon(
              Icons.cloud,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              LocaleKeys.common_temp.tr(
                args: [forecast.main?.temp?.toInt().toString() ?? ''],
              ),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
