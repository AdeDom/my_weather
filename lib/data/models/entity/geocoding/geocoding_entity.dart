import 'package:freezed_annotation/freezed_annotation.dart';

part 'geocoding_entity.freezed.dart';
part 'geocoding_entity.g.dart';

@freezed
class GeocodingEntity with _$GeocodingEntity {
  factory GeocodingEntity({
    required String name,
    double? lat,
    double? lon,
    required String state,
  }) = _GeocodingEntity;

  factory GeocodingEntity.fromJson(Map<String, Object?> json) =>
      _$GeocodingEntityFromJson(json);
}
