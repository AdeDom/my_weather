import 'package:my_weather/src/data/data_source/local/constants/database_constant.dart';
import 'package:my_weather/src/data/data_source/local/providers/database_providers.dart';
import 'package:my_weather/src/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqlite_api.dart';

part 'open_weather_local_data_source.g.dart';

abstract class OpenWeatherLocalDataSource {
  Future<List<GeographicalCoordinatesEntity>> getGeographicalCoordinatesAll();

  void addGeographicalCoordinates(GeographicalCoordinatesEntity entity);

  void deleteByIds(List<String> selectIds);
}

class OpenWeatherLocalDataSourceImpl extends OpenWeatherLocalDataSource {
  OpenWeatherLocalDataSourceImpl({
    required this.database,
  });

  final Database database;

  @override
  Future<List<GeographicalCoordinatesEntity>>
      getGeographicalCoordinatesAll() async {
    final list = await database.query(
      DatabaseConstant.geographicalCoordinatesTableName,
    );
    return list
        .map((element) => GeographicalCoordinatesEntity.fromJson(element))
        .toList();
  }

  @override
  void addGeographicalCoordinates(GeographicalCoordinatesEntity entity) {
    database.insert(
      DatabaseConstant.geographicalCoordinatesTableName,
      entity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  void deleteByIds(List<String> selectIds) {
    final entryIds = selectIds.map((element) => "'$element'").join(',');
    String sql = '''
      DELETE FROM geographical_coordinates
      WHERE id IN ($entryIds);
    ''';
    database.rawDelete(sql);
  }
}

@riverpod
OpenWeatherLocalDataSource openWeatherLocalDataSource(
  OpenWeatherLocalDataSourceRef ref,
) {
  final database = ref.watch(databaseProvider);
  return OpenWeatherLocalDataSourceImpl(database: database);
}
