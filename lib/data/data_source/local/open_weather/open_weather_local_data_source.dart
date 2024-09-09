import 'dart:convert';

import 'package:my_weather/data/data_source/local/providers/shared_preferences_provider.dart';
import 'package:my_weather/data/models/entity/geocoding/geocoding_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'open_weather_local_data_source.g.dart';

abstract class OpenWeatherLocalDataSource {
  List<GeocodingEntity> getGeocodingAll();

  void addGeocoding(GeocodingEntity geocoding);

  void removeGeocoding(GeocodingEntity geocoding);
}

class OpenWeatherLocalDataSourceImpl extends OpenWeatherLocalDataSource {
  OpenWeatherLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;
  static const _geoCodingKey = 'geo_coding';

  @override
  List<GeocodingEntity> getGeocodingAll() {
    final json = sharedPreferences.getString(_geoCodingKey);
    if (json == null) {
      return [];
    }

    final jsonDec = jsonDecode(json);
    List<GeocodingEntity> geocodingList = List<GeocodingEntity>.from(
      jsonDec.map((model) => GeocodingEntity.fromJson(model)),
    );
    return geocodingList;
  }

  @override
  void addGeocoding(GeocodingEntity geocoding) {
    final geocodingList = getGeocodingAll();
    final isGeocoding = geocodingList
        .where((e) => e.name == geocoding.name && e.state == geocoding.state)
        .firstOrNull;

    if (isGeocoding == null) {
      geocodingList.add(geocoding);
      var json = jsonEncode(geocodingList.map((e) => e.toJson()).toList());
      sharedPreferences.setString(_geoCodingKey, json);
    }
  }

  @override
  void removeGeocoding(GeocodingEntity geocoding) {
    final geocodingList = getGeocodingAll();
    final data = geocodingList
        .map((element) {
          final isName = element.name == geocoding.name;
          final isState = element.state == geocoding.state;
          final isDelete = isName && isState;
          return isDelete ? null : element;
        })
        .whereType<GeocodingEntity>()
        .map((element) => element.toJson())
        .toList();
    var json = jsonEncode(data);
    sharedPreferences.setString(_geoCodingKey, json);
  }
}

@riverpod
OpenWeatherLocalDataSource openWeatherLocalDataSource(
  OpenWeatherLocalDataSourceRef ref,
) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return OpenWeatherLocalDataSourceImpl(sharedPreferences: sharedPreferences);
}
