import 'package:freezed_annotation/freezed_annotation.dart';

part 'wind_response.freezed.dart';
part 'wind_response.g.dart';

@freezed
class WindResponse with _$WindResponse {
  factory WindResponse({
    double? speed,
    int? deg,
    double? gust,
  }) = _WindResponse;

  factory WindResponse.fromJson(Map<String, Object?> json) =>
      _$WindResponseFromJson(json);
}
