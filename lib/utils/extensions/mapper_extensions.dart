import 'package:my_weather/data/models/entity/geocoding/geocoding_entity.dart';
import 'package:my_weather/data/models/enum/app_weather.dart';
import 'package:my_weather/data/models/enum/date_time_format.dart';
import 'package:my_weather/data/models/response/current_weather/current_weather_response.dart';
import 'package:my_weather/data/models/response/forecast/forecast_response.dart';
import 'package:my_weather/data/models/response/geocoding/geocoding_response.dart';
import 'package:my_weather/domain/models/forecast/forecast_model.dart';
import 'package:my_weather/domain/models/home/current_weather_model.dart';
import 'package:my_weather/domain/models/home/geocoding_model.dart';
import 'package:my_weather/domain/models/home/home_forecast_model.dart';
import 'package:my_weather/domain/models/manage_cities/add_city_model.dart';
import 'package:my_weather/domain/models/manage_cities/manage_cities_model.dart';
import 'package:my_weather/utils/extensions/double_extensions.dart';
import 'package:my_weather/utils/extensions/int_extensions.dart';

extension CurrentWeatherResponseToCurrentWeatherModel
    on CurrentWeatherResponse {
  CurrentWeatherModel toCurrentWeatherModel() {
    final weatherFirst = weather?.firstOrNull;
    final tempMin = main?.tempMin?.temperature;
    final tempMax = main?.tempMax?.temperature;
    final tempMinMax = '$tempMin°/$tempMax°';
    return CurrentWeatherModel(
      weather: weatherFirst?.main ?? AppWeather.unknown,
      temp: main?.temp?.toInt(),
      description: weatherFirst?.description ?? '',
      tempMinMax: tempMinMax,
      humidity: main?.humidity,
    );
  }
}

extension GeocodingResponseToAddCityModel on GeocodingResponse {
  AddCityModel toAddCityModel() {
    return AddCityModel(
      name: name ?? 'Unknown',
      lat: lat,
      lon: lon,
      state: state ?? 'Unknown',
    );
  }
}

extension ForecastResponseToModel on Forecast {
  HomeForecastModel toHomeForecastModel() {
    final weatherFirst = weather?.firstOrNull;
    return HomeForecastModel(
      weather: weatherFirst?.main ?? AppWeather.unknown,
      temp: main?.temp?.toInt(),
      time: dt?.convertDateTime(DateTimeFormat.time) ?? '',
    );
  }

  ForecastModel toForecastModel() {
    final weatherFirst = weather?.firstOrNull;
    final tempMin = main?.tempMin?.temperature;
    final tempMax = main?.tempMax?.temperature;
    return ForecastModel(
      weather: weatherFirst?.main ?? AppWeather.unknown,
      temp: main?.temp?.toInt(),
      tempMinMax: '$tempMin°/$tempMax°',
      dateTime: dt?.convertDateTime(DateTimeFormat.dateTime) ?? '',
    );
  }
}

extension GeocodingEntityToModel on GeocodingEntity {
  GeocodingModel toGeocodingModel() {
    return GeocodingModel(
      name: name,
      lat: lat,
      lon: lon,
    );
  }

  ManageCitiesModel toManageCitiesModel() {
    return ManageCitiesModel(
      name: name,
      state: state,
      isRemove: false,
    );
  }
}

extension ManageCitiesModelToGeocodingEntity on ManageCitiesModel {
  GeocodingEntity toGeocodingEntity() {
    return GeocodingEntity(
      name: name,
      lat: null,
      lon: null,
      state: state,
    );
  }
}

extension AddCityModelToGeocodingEntity on AddCityModel {
  GeocodingEntity toGeocodingEntity() {
    return GeocodingEntity(
      name: name,
      lat: lat,
      lon: lon,
      state: state,
    );
  }
}
