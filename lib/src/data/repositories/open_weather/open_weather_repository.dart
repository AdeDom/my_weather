import 'package:my_weather/src/data/data_source/local/open_weather/open_weather_local_data_source.dart';
import 'package:my_weather/src/data/data_source/remote/open_weather/open_weather_remote_data_source.dart';
import 'package:my_weather/src/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';
import 'package:my_weather/src/data/models/response/current_weather/current_weather_response.dart';
import 'package:my_weather/src/data/models/response/forecast/forecast_response.dart';
import 'package:my_weather/src/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/src/data/repositories/app_settings/app_settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'open_weather_repository.g.dart';

abstract class OpenWeatherRepository {
  Future<List<GeographicalCoordinatesEntity>> getGeographicalCoordinatesAll();

  void addGeographicalCoordinates(GeographicalCoordinatesEntity entity);

  void deleteByIds(List<String> selectIds);

  Future<CurrentWeatherResponse> fetchCurrentWeather(
    double lat,
    double lon,
  );

  Future<List<ForecastItemResponse>> fetchForecast(
    double lat,
    double lon,
  );

  Future<List<GeographicalCoordinatesResponse>> fetchGeographicalCoordinates(
    String search,
  );
}

class OpenWeatherRepositoryImpl extends OpenWeatherRepository {
  OpenWeatherRepositoryImpl({
    required this.openWeatherLocalDataSource,
    required this.openWeatherRemoteDataSource,
    required this.appSettingsRepository,
  });

  OpenWeatherLocalDataSource openWeatherLocalDataSource;
  OpenWeatherRemoteDataSource openWeatherRemoteDataSource;
  AppSettingsRepository appSettingsRepository;

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
  ) {
    final temperature = appSettingsRepository.getAppTemperature();
    return openWeatherRemoteDataSource.fetchCurrentWeather(
      lat,
      lon,
      temperature.units,
    );
  }

  @override
  Future<List<ForecastItemResponse>> fetchForecast(
    double lat,
    double lon,
  ) async {
    final temperature = appSettingsRepository.getAppTemperature();
    final result = await openWeatherRemoteDataSource.fetchForecast(
      lat,
      lon,
      temperature.units,
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
  final appSettingsRepository = ref.watch(appSettingsRepositoryProvider);
  return OpenWeatherRepositoryImpl(
    openWeatherLocalDataSource: openWeatherLocalDataSource,
    openWeatherRemoteDataSource: openWeatherRemoteDataSource,
    appSettingsRepository: appSettingsRepository,
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
Future<CurrentWeatherResponse> fetchCurrentWeather(
  FetchCurrentWeatherRef ref, {
  required double lat,
  required double lon,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  return openWeatherRepository.fetchCurrentWeather(lat, lon);
}

@riverpod
Future<List<ForecastItemResponse>> fetchForecast(
  FetchForecastRef ref, {
  required double lat,
  required double lon,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  return openWeatherRepository.fetchForecast(lat, lon);
}

@riverpod
Future<List<GeographicalCoordinatesResponse>> fetchGeographicalCoordinates(
  FetchGeographicalCoordinatesRef ref, {
  required String search,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  return openWeatherRepository.fetchGeographicalCoordinates(search);
}
