import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/data/models/response/forecast/forecast_response.dart';
import 'package:my_weather/src/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/src/presentation/forecast/models/forecast_argument.dart';
import 'package:my_weather/src/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/src/ui/common_widgets/app_loading_widget.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';
import 'package:my_weather/src/ui/common_widgets/weather_icon_widget.dart';
import 'package:my_weather/src/utils/enum/date_time_format.dart';
import 'package:my_weather/src/utils/extensions/double_extensions.dart';
import 'package:my_weather/src/utils/extensions/int_extensions.dart';

class ForecastScreen extends ConsumerStatefulWidget {
  const ForecastScreen({
    super.key,
    required this.args,
  });

  final ForecastArgument args;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends ConsumerState<ForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(LocaleKeys.forecast_forecast.tr()),
      ),
      body: _buildListViewWidget(),
    );
  }

  Widget _buildListViewWidget() {
    final lat = widget.args.lat;
    final lon = widget.args.lon;

    if (lat == null || lon == null) {
      return AppErrorWidget(
        message: LocaleKeys.common_something_went_wrong.tr(),
      );
    }

    final result = ref.watch(fetchForecastProvider(lat: lat, lon: lon));

    return result.when(
      data: (data) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p16,
            vertical: Sizes.p8,
          ),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildForecastItemWidget(data[index]);
          },
        );
      },
      error: (error, _) => AppErrorWidget(message: error.toString()),
      loading: () => const AppLoadingWidget(),
    );
  }

  Widget _buildForecastItemWidget(ForecastItemResponse forecast) {
    final weatherFirst = forecast.weather?.firstOrNull;
    final tempMin = forecast.main?.tempMin?.temperature ?? '';
    final tempMax = forecast.main?.tempMax?.temperature ?? '';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p8),
        child: Row(
          children: [
            SizedBox(
              width: Sizes.p32,
              child: WeatherIconWidget(weather: weatherFirst?.main),
            ),
            const SizedBox(width: Sizes.p8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weatherFirst?.main.value ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  forecast.dt?.convertDateTime(DateTimeFormat.dateTime) ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const Spacer(),
            Text(
              LocaleKeys.common_temp.tr(
                args: [forecast.main?.temp?.toInt().toString() ?? ''],
              ),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(width: Sizes.p16),
            Text(
              LocaleKeys.common_temp_min_max.tr(args: [tempMin, tempMax]),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
