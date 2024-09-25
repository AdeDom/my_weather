import 'package:freezed_annotation/freezed_annotation.dart';

part 'clouds_response.freezed.dart';
part 'clouds_response.g.dart';

@freezed
class CloudsResponse with _$CloudsResponse {
  factory CloudsResponse({
    int? all,
  }) = _CloudsResponse;

  factory CloudsResponse.fromJson(Map<String, Object?> json) =>
      _$CloudsResponseFromJson(json);
}
