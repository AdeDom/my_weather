import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_weather/src/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';

part 'geographical_coordinates_entity.freezed.dart';
part 'geographical_coordinates_entity.g.dart';

@freezed
class GeographicalCoordinatesEntity with _$GeographicalCoordinatesEntity {
  factory GeographicalCoordinatesEntity({
    required String id,
    required String name,
    double? lat,
    double? lon,
    required String state,
  }) = _GeographicalCoordinatesEntity;

  factory GeographicalCoordinatesEntity.fromJson(Map<String, Object?> json) =>
      _$GeographicalCoordinatesEntityFromJson(json);

  factory GeographicalCoordinatesEntity.fromResponse({
    required GeographicalCoordinatesResponse data,
  }) {
    return GeographicalCoordinatesEntity(
      id: '${data.name}${data.state}',
      name: data.name ?? 'Unknown',
      lat: data.lat,
      lon: data.lon,
      state: data.state ?? 'Unknown',
    );
  }
}
