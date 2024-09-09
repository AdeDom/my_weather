import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/domain/models/forecast/forecast_model.dart';
import 'package:my_weather/presentation/forecast/models/forecast_argument.dart';
import 'package:my_weather/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/ui/common_widgets/app_loading_widget.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';
import 'package:my_weather/ui/common_widgets/weather_icon_widget.dart';

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
        title: const Text('Forecast'),
      ),
      body: _buildListViewWidget(),
    );
  }

  Widget _buildListViewWidget() {
    final lat = widget.args.lat;
    final lon = widget.args.lon;
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

  Widget _buildForecastItemWidget(ForecastModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p8),
        child: Row(
          children: [
            SizedBox(
              width: Sizes.p32,
              child: WeatherIconWidget(weather: data.weather),
            ),
            const SizedBox(width: Sizes.p8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.weather.value,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  data.dateTime,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const Spacer(),
            Text(
              '${data.temp}°',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(width: Sizes.p16),
            Text(
              data.tempMinMax,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
