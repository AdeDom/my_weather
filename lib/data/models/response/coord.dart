import 'package:freezed_annotation/freezed_annotation.dart';

part 'coord.freezed.dart';
part 'coord.g.dart';

@freezed
class Coord with _$Coord {
  factory Coord({
    @JsonKey(name: 'lat') double? lat,
    @JsonKey(name: 'lon') double? lon,
  }) = _Coord;

  factory Coord.fromJson(Map<String, Object?> json) => _$CoordFromJson(json);
}
