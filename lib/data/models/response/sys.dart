import 'package:freezed_annotation/freezed_annotation.dart';

part 'sys.freezed.dart';
part 'sys.g.dart';

@freezed
class Sys with _$Sys {
  factory Sys({
    @JsonKey(name: 'type') int? type,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'sunrise') int? sunrise,
    @JsonKey(name: 'sunset') int? sunset,
    @JsonKey(name: 'pod') String? pod,
  }) = _Sys;

  factory Sys.fromJson(Map<String, Object?> json) => _$SysFromJson(json);
}
