import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_response.freezed.dart';
part 'main_response.g.dart';

@freezed
class MainResponse with _$MainResponse {
  factory MainResponse({
    double? temp,
    @JsonKey(name: 'feels_like') double? feelsLike,
    @JsonKey(name: 'temp_min') double? tempMin,
    @JsonKey(name: 'temp_max') double? tempMax,
    int? pressure,
    @JsonKey(name: 'sea_level') int? seaLevel,
    @JsonKey(name: 'grnd_level') int? grndLevel,
    int? humidity,
    @JsonKey(name: 'temp_kf') double? tempKf,
  }) = _MainResponse;

  factory MainResponse.fromJson(Map<String, Object?> json) =>
      _$MainResponseFromJson(json);
}
