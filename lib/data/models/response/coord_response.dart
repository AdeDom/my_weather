import 'package:freezed_annotation/freezed_annotation.dart';

part 'coord_response.freezed.dart';
part 'coord_response.g.dart';

@freezed
class CoordResponse with _$CoordResponse {
  factory CoordResponse({
    double? lat,
    double? lon,
  }) = _CoordResponse;

  factory CoordResponse.fromJson(Map<String, Object?> json) =>
      _$CoordResponseFromJson(json);
}
