import 'package:freezed_annotation/freezed_annotation.dart';

part 'rain_response.freezed.dart';
part 'rain_response.g.dart';

@freezed
class RainResponse with _$RainResponse {
  factory RainResponse({
    @JsonKey(name: '3h') double? h,
  }) = _RainResponse;

  factory RainResponse.fromJson(Map<String, Object?> json) =>
      _$RainResponseFromJson(json);
}
