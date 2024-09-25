import 'package:freezed_annotation/freezed_annotation.dart';

part 'sys_response.freezed.dart';
part 'sys_response.g.dart';

@freezed
class SysResponse with _$SysResponse {
  factory SysResponse({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
    String? pod,
  }) = _SysResponse;

  factory SysResponse.fromJson(Map<String, Object?> json) =>
      _$SysResponseFromJson(json);
}
