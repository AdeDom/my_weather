import 'package:my_weather/data/data_source/local/providers/database_providers.dart';
import 'package:my_weather/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';
import 'package:my_weather/utils/constants/app_constant.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqlite_api.dart';

part 'open_weather_local_data_source.g.dart';

abstract class OpenWeatherLocalDataSource {
  Future<List<GeographicalCoordinatesEntity>> getGeographicalCoordinatesAll();

  void addGeographicalCoordinates(GeographicalCoordinatesEntity entity);

  void removeGeographicalCoordinates(GeographicalCoordinatesEntity entity);
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
      AppConstant.geographicalCoordinatesTableName,
    );
    return list
        .map((element) => GeographicalCoordinatesEntity.fromJson(element))
        .toList();
  }

  @override
  void addGeographicalCoordinates(GeographicalCoordinatesEntity entity) {
    database.insert(
      AppConstant.geographicalCoordinatesTableName,
      entity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  void removeGeographicalCoordinates(GeographicalCoordinatesEntity entity) {
    database.delete(
      AppConstant.geographicalCoordinatesTableName,
      where: 'id = ?',
      whereArgs: [entity.id],
    );
  }
}

@riverpod
OpenWeatherLocalDataSource openWeatherLocalDataSource(
  OpenWeatherLocalDataSourceRef ref,
) {
  final database = ref.watch(databaseProvider);
  return OpenWeatherLocalDataSourceImpl(database: database);
}
