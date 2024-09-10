import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/data/data_source/remote/interceptor/base_interceptor.dart';
import 'package:my_weather/data/models/response/current_weather/current_weather_response.dart';
import 'package:my_weather/data/models/response/forecast/forecast_response.dart';
import 'package:my_weather/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/utils/constants/app_constant.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'open_weather_remote_data_source.g.dart';

@RestApi(baseUrl: AppConstant.baseUrl)
abstract class OpenWeatherRemoteDataSource {
  factory OpenWeatherRemoteDataSource(Dio dio) = _OpenWeatherRemoteDataSource;

  @GET('data/2.5/weather')
  Future<CurrentWeatherResponse> fetchCurrentWeather(
    @Query('lat') double? lat,
    @Query('lon') double? lon,
    @Query('units') String units,
  );

  @GET('data/2.5/forecast')
  Future<ForecastResponse> fetchForecast(
    @Query('lat') double? lat,
    @Query('lon') double? lon,
    @Query('units') String units,
  );

  @GET('geo/1.0/direct')
  Future<List<GeographicalCoordinatesResponse>> fetchGeographicalCoordinates(
    @Query('q') String search,
    @Query('limit') int limit,
  );
}

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio();
  dio.interceptors.addAll([
    BaseInterceptor(),
    LogInterceptor(logPrint: (o) => debugPrint(o.toString())),
  ]);
  return dio;
}

@riverpod
OpenWeatherRemoteDataSource openWeatherRemoteDataSource(
  OpenWeatherRemoteDataSourceRef ref,
) {
  final dio = ref.watch(dioProvider);
  return OpenWeatherRemoteDataSource(dio);
}
