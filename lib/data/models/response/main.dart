import 'package:freezed_annotation/freezed_annotation.dart';

part 'main.freezed.dart';
part 'main.g.dart';

@freezed
class Main with _$Main {
  factory Main({
    @JsonKey(name: 'temp') double? temp,
    @JsonKey(name: 'feels_like') double? feelsLike,
    @JsonKey(name: 'temp_min') double? tempMin,
    @JsonKey(name: 'temp_max') double? tempMax,
    @JsonKey(name: 'pressure') int? pressure,
    @JsonKey(name: 'sea_level') int? seaLevel,
    @JsonKey(name: 'grnd_level') int? grndLevel,
    @JsonKey(name: 'humidity') int? humidity,
    @JsonKey(name: 'temp_kf') double? tempKf,
  }) = _Main;

  factory Main.fromJson(Map<String, Object?> json) => _$MainFromJson(json);
}
