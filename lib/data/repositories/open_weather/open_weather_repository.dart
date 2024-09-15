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

  void deleteByIds(List<String> selectIds);

  Future<CurrentWeatherResponse> fetchCurrentWeather(
    double lat,
    double lon,
    String units,
  );

  Future<List<ForecastItemResponse>> fetchForecast(
    double lat,
    double lon,
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
  void deleteByIds(List<String> selectIds) {
    return openWeatherLocalDataSource.deleteByIds(selectIds);
  }

  @override
  Future<CurrentWeatherResponse> fetchCurrentWeather(
    double lat,
    double lon,
    String units,
  ) async {
    return openWeatherRemoteDataSource.fetchCurrentWeather(
      lat,
      lon,
      units,
    );
  }

  @override
  Future<List<ForecastItemResponse>> fetchForecast(
    double lat,
    double lon,
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
void deleteByIds(
  DeleteByIdsRef ref, {
  required List<String> selectIds,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  return openWeatherRepository.deleteByIds(selectIds);
}

@riverpod
Future<CurrentWeatherResponse> fetchCurrentWeather(
  FetchCurrentWeatherRef ref, {
  required double lat,
  required double lon,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  final temperature = ref.watch(getAppTemperatureProvider);
  return openWeatherRepository.fetchCurrentWeather(lat, lon, temperature.units);
}

@riverpod
Future<List<ForecastItemResponse>> fetchForecast(
  FetchForecastRef ref, {
  required double lat,
  required double lon,
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
