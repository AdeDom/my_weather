import 'package:freezed_annotation/freezed_annotation.dart';

part 'clouds.freezed.dart';
part 'clouds.g.dart';

@freezed
class Clouds with _$Clouds {
  factory Clouds({
    @JsonKey(name: 'all') int? all,
  }) = _Clouds;

  factory Clouds.fromJson(Map<String, Object?> json) => _$CloudsFromJson(json);
}
