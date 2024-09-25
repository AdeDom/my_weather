import 'package:flutter_test/flutter_test.dart';
import 'package:my_weather/src/data/data_source/local/open_weather/open_weather_local_data_source.dart';
import 'package:my_weather/src/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';

class FakeOpenWeatherLocalDataSource extends OpenWeatherLocalDataSource {
  List<GeographicalCoordinatesEntity> geographicalCoordinatesList = [];

  @override
  Future<List<GeographicalCoordinatesEntity>> getGeographicalCoordinatesAll() {
    return Future.value(geographicalCoordinatesList);
  }

  @override
  void addGeographicalCoordinates(GeographicalCoordinatesEntity entity) {
    geographicalCoordinatesList.add(entity);
  }

  @override
  void deleteByIds(List<String> selectIds) {
    for (var element in selectIds) {
      geographicalCoordinatesList.removeWhere((e) => e.id == element);
    }
  }
}
