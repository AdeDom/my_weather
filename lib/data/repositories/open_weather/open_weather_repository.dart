import 'package:my_weather/data/data_source/local/open_weather/open_weather_local_data_source.dart';
import 'package:my_weather/data/data_source/remote/open_weather/open_weather_remote_data_source.dart';
import 'package:my_weather/data/models/entity/geocoding/geocoding_entity.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/domain/models/forecast/forecast_model.dart';
import 'package:my_weather/domain/models/home/current_weather_model.dart';
import 'package:my_weather/domain/models/home/geocoding_model.dart';
import 'package:my_weather/domain/models/home/home_forecast_model.dart';
import 'package:my_weather/domain/models/manage_cities/add_city_model.dart';
import 'package:my_weather/domain/models/manage_cities/manage_cities_model.dart';
import 'package:my_weather/utils/extensions/mapper_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'open_weather_repository.g.dart';

abstract class OpenWeatherRepository {
  List<GeocodingModel> getGeocodingAll();

  List<ManageCitiesModel> getManageCities();

  void addGeocoding(GeocodingEntity geocoding);

  void removeGeocoding(GeocodingEntity geocoding);

  Future<CurrentWeatherModel> fetchCurrentWeather(
    double? lat,
    double? lon,
    String units,
  );

  Future<List<HomeForecastModel>> fetchHomeForecast(
    double? lat,
    double? lon,
    String units,
  );

  Future<List<ForecastModel>> fetchForecast(
    double? lat,
    double? lon,
    String units,
  );

  Future<List<AddCityModel>> fetchGeocoding(String search);
}

class OpenWeatherRepositoryImpl extends OpenWeatherRepository {
  OpenWeatherRepositoryImpl({
    required this.openWeatherLocalDataSource,
    required this.openWeatherRemoteDataSource,
  });

  OpenWeatherLocalDataSource openWeatherLocalDataSource;
  OpenWeatherRemoteDataSource openWeatherRemoteDataSource;

  @override
  List<GeocodingModel> getGeocodingAll() {
    return openWeatherLocalDataSource
        .getGeocodingAll()
        .map((element) => element.toGeocodingModel())
        .toList();
  }

  @override
  List<ManageCitiesModel> getManageCities() {
    return openWeatherLocalDataSource
        .getGeocodingAll()
        .map((element) => element.toManageCitiesModel())
        .toList();
  }

  @override
  void addGeocoding(GeocodingEntity geocoding) {
    return openWeatherLocalDataSource.addGeocoding(geocoding);
  }

  @override
  void removeGeocoding(GeocodingEntity geocoding) {
    return openWeatherLocalDataSource.removeGeocoding(geocoding);
  }

  @override
  Future<CurrentWeatherModel> fetchCurrentWeather(
    double? lat,
    double? lon,
    String units,
  ) async {
    final result = await openWeatherRemoteDataSource.fetchCurrentWeather(
      lat,
      lon,
      units,
    );
    return result.toCurrentWeatherModel();
  }

  @override
  Future<List<HomeForecastModel>> fetchHomeForecast(
    double? lat,
    double? lon,
    String units,
  ) async {
    final result = await openWeatherRemoteDataSource.fetchForecast(
      lat,
      lon,
      units,
    );
    return result.list
            ?.map((element) => element.toHomeForecastModel())
            .toList() ??
        [];
  }

  @override
  Future<List<ForecastModel>> fetchForecast(
    double? lat,
    double? lon,
    String units,
  ) async {
    final result = await openWeatherRemoteDataSource.fetchForecast(
      lat,
      lon,
      units,
    );
    return result.list?.map((element) => element.toForecastModel()).toList() ??
        [];
  }

  @override
  Future<List<AddCityModel>> fetchGeocoding(String search) async {
    final result = await openWeatherRemoteDataSource.fetchGeocoding(search, 5);
    return result.map((element) => element.toAddCityModel()).toList();
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
List<GeocodingModel> getGeocodingAll(GetGeocodingAllRef ref) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  return openWeatherRepository.getGeocodingAll();
}

@riverpod
List<ManageCitiesModel> getManageCities(GetManageCitiesRef ref) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  return openWeatherRepository.getManageCities();
}

@riverpod
void addGeocoding(
  AddGeocodingRef ref, {
  required AddCityModel addCity,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  return openWeatherRepository.addGeocoding(addCity.toGeocodingEntity());
}

@riverpod
void removeGeocoding(
  RemoveGeocodingRef ref, {
  required GeocodingEntity geocoding,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  return openWeatherRepository.removeGeocoding(geocoding);
}

@riverpod
Future<CurrentWeatherModel> fetchCurrentWeather(
  FetchCurrentWeatherRef ref, {
  double? lat,
  double? lon,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  final temperature = ref.watch(getAppTemperatureProvider);
  return openWeatherRepository.fetchCurrentWeather(lat, lon, temperature.units);
}

@riverpod
Future<List<HomeForecastModel>> fetchHomeForecast(
  FetchHomeForecastRef ref, {
  double? lat,
  double? lon,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  final temperature = ref.watch(getAppTemperatureProvider);
  return openWeatherRepository.fetchHomeForecast(lat, lon, temperature.units);
}

@riverpod
Future<List<ForecastModel>> fetchForecast(
  FetchForecastRef ref, {
  double? lat,
  double? lon,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  final temperature = ref.watch(getAppTemperatureProvider);
  return openWeatherRepository.fetchForecast(lat, lon, temperature.units);
}

@riverpod
Future<List<AddCityModel>> fetchGeocoding(
  FetchGeocodingRef ref, {
  required String search,
}) {
  final openWeatherRepository = ref.watch(openWeatherRepositoryProvider);
  return openWeatherRepository.fetchGeocoding(search);
}
