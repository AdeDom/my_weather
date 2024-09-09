import 'package:freezed_annotation/freezed_annotation.dart';

part 'rain.freezed.dart';
part 'rain.g.dart';

@freezed
class Rain with _$Rain {
  factory Rain({
    @JsonKey(name: '3h') double? h,
  }) = _Rain;

  factory Rain.fromJson(Map<String, Object?> json) => _$RainFromJson(json);
}
