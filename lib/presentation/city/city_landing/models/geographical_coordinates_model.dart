import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_weather/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';
import 'package:my_weather/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';

part 'geographical_coordinates_model.freezed.dart';
part 'geographical_coordinates_model.g.dart';

@freezed
class GeographicalCoordinatesModel with _$GeographicalCoordinatesModel {
  factory GeographicalCoordinatesModel({
    required String id,
    required String name,
    double? lat,
    double? lon,
    required String state,
    @Default(false) bool isDelete,
  }) = _GeographicalCoordinatesModel;

  factory GeographicalCoordinatesModel.fromJson(Map<String, Object?> json) =>
      _$GeographicalCoordinatesModelFromJson(json);

  factory GeographicalCoordinatesModel.fromEntity({
    required GeographicalCoordinatesEntity data,
  }) {
    return GeographicalCoordinatesModel(
      id: data.id,
      name: data.name,
      lat: data.lat,
      lon: data.lon,
      state: data.state,
      isDelete: false,
    );
  }

  factory GeographicalCoordinatesModel.fromResponse({
    required GeographicalCoordinatesResponse data,
  }) {
    return GeographicalCoordinatesModel(
      id: '${data.name}${data.state}',
      name: data.name ?? 'Unknown',
      lat: data.lat,
      lon: data.lon,
      state: data.state ?? 'Unknown',
      isDelete: false,
    );
  }
}
