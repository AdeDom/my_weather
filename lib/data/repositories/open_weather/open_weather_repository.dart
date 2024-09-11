import 'package:my_weather/data/data_source/local/open_weather/open_weather_local_data_source.dart';
import 'package:my_weather/data/data_source/remote/open_weather/open_weather_remote_data_source.dart';
import 'package:my_weather/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';
import 'package:my_weather/data/models/response/current_weather/current_weather_response.dart';
import 'package:my_weather/data/models/response/forecast/forecast_response.dart';
import 'package:my_weather/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'open_weather_repository.g.dart';

abstract class OpenWeatherRepository {
  Future<List<GeographicalCoordinatesEntity>> getGeographicalCoordinatesAll();

  void addGeographicalCoordinates(GeographicalCoordinatesEntity entity);

  void removeGeographicalCoordinates(GeographicalCoordinatesEntity entity);

  Future<CurrentWeatherResponse> fetchCurrentWeather(
    double? lat,
    double? lon,
    String units,
  );

  Future<List<Forecast>> fetchForecast(
    double? lat,
    double? lon,
    String units,
  );

  Future<List<GeographicalCoordinatesResponse>> fetchGeographicalCoordinates(
    String search,
  );
}

class OpenWeatherRepositoryImpl extends OpenWeatherRepository {
  OpenWeatherRepositoryImpl({
    required this.openWeatherLocalDataSource,
    required this.openWeatherRemoteDataSource,
  });

  OpenWeatherLocalDataSource openWeatherLocalDataSource;
  OpenWeatherRemoteDataSource openWeatherRemoteDataSource;

  @override
  Future<List<GeographicalCoordinatesEntity>> getGeographicalCoordinatesAll() {
    return openWeatherLocalDataSource.getGeographicalCoordinatesAll();
  }

  @override
  void addGeographicalCoordinates(GeographicalCoordinatesEntity entity) {
    return openWeatherLocalDataSource.addGeographicalCoordinates(entity);
  }

  @override
  void removeGeographicalCoordinates(GeographicalCoordinatesEntity entity) {
    return openWeatherLocalDataSource.removeGeographicalCoordinates(entity);
  }

  @override
  Future<CurrentWeatherResponse> fetchCurrentWeather(
    double? lat,
    double? lon,
    String units,
  ) async {
    return openWeatherRemoteDataSource.fetchCurrentWeather(
      lat,
      lon,
      units,
    );
  }

  @override
  Future<List<Forecast>> fetchForecast(
    double? lat,
    double? lon,
    String units,
  ) async {
    final result = await openWeatherRemoteDataSource.fetchForecast(
      lat,
      lon,
      units,
    );
    return result.list ?? [];
  }

  @override
  Future<List<GeographicalCoordinatesResponse>> fetchGeographicalCoordinates(
    String search,
  ) {
    const limit = 5;
    return openWeatherRemoteDataSource.fetchGeographicalCoordinates(
      search,
      limit,
    );
  }
}

@riverpod
OpenWeatherRepository openWeatherRepository(OpenWeatherRepositoryRef ref) {
  final openWeatherLocalDataSource =
      ref.watch(openWeatherLocalDataSourceProvider);
  final openWeatherRemoteDataSource =
      ref.watch(openWeatherRemoteDataSourceProvider);
  return OpenWeatherRepositoryImpl(
    openWeatherLocalDataSource: openWeatherLocalDataSource,
    openWeatherRemoteDataSource: openWeatherRemoteDataSource,
  );
}

@riverpod
Future<List<GeographicalCoordinatesEntity>> getGeographicalCoordinatesAll(
  GetGeographicalCoordinatesAllRef ref,
) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  return openWeatherRepository.getGeographicalCoordinatesAll();
}

@riverpod
void addGeographicalCoordinates(
  AddGeographicalCoordinatesRef ref, {
  required GeographicalCoordinatesResponse geographicalCoordinates,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  final entity = GeographicalCoordinatesEntity.fromResponse(
    data: geographicalCoordinates,
  );
  return openWeatherRepository.addGeographicalCoordinates(entity);
}

@riverpod
void removeGeographicalCoordinates(
  RemoveGeographicalCoordinatesRef ref, {
  required GeographicalCoordinatesEntity entity,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  return openWeatherRepository.removeGeographicalCoordinates(entity);
}

@riverpod
Future<CurrentWeatherResponse> fetchCurrentWeather(
  FetchCurrentWeatherRef ref, {
  double? lat,
  double? lon,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  final temperature = ref.watch(getAppTemperatureProvider);
  return openWeatherRepository.fetchCurrentWeather(lat, lon, temperature.units);
}

@riverpod
Future<List<Forecast>> fetchForecast(
  FetchForecastRef ref, {
  double? lat,
  double? lon,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  final temperature = ref.watch(getAppTemperatureProvider);
  return openWeatherRepository.fetchForecast(lat, lon, temperature.units);
}

@riverpod
Future<List<GeographicalCoordinatesResponse>> fetchGeographicalCoordinates(
  FetchGeographicalCoordinatesRef ref, {
  required String search,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  return openWeatherRepository.fetchGeographicalCoordinates(search);
}
