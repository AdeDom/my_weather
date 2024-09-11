import 'package:freezed_annotation/freezed_annotation.dart';

part 'sys_response.freezed.dart';
part 'sys_response.g.dart';

@freezed
class SysResponse with _$SysResponse {
  factory SysResponse({
    @JsonKey(name: 'type') int? type,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'sunrise') int? sunrise,
    @JsonKey(name: 'sunset') int? sunset,
    @JsonKey(name: 'pod') String? pod,
  }) = _SysResponse;

  factory SysResponse.fromJson(Map<String, Object?> json) =>
      _$SysResponseFromJson(json);
}
