import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'geocoding_response.freezed.dart';
part 'geocoding_response.g.dart';

@freezed
class GeocodingResponse with _$GeocodingResponse {
  factory GeocodingResponse({
    String? name,
    LocalNames? localNames,
    double? lat,
    double? lon,
    String? country,
    String? state,
  }) = _GeocodingResponse;

  factory GeocodingResponse.fromJson(Map<String, Object?> json) =>
      _$GeocodingResponseFromJson(json);
}

@freezed
class LocalNames with _$LocalNames {
  factory LocalNames({
    String? ms,
    String? gu,
    // String? is,
    String? wa,
    String? mg,
    String? gl,
    String? om,
    String? ku,
    String? tw,
    String? mk,
    String? ee,
    String? fj,
    String? gd,
    String? ky,
    String? yo,
    String? zu,
    String? bg,
    String? tk,
    String? co,
    String? sh,
    String? de,
    String? kl,
    String? bi,
    String? km,
    String? lt,
    String? fi,
    String? fy,
    String? ba,
    String? sc,
    String? featureName,
    String? ja,
    String? am,
    String? sk,
    String? mr,
    String? es,
    String? sq,
    String? te,
    String? br,
    String? uz,
    String? da,
    String? sw,
    String? fa,
    String? sr,
    String? cu,
    String? ln,
    String? na,
    String? wo,
    String? ig,
    String? to,
    String? ta,
    String? mt,
    String? ar,
    String? su,
    String? ab,
    String? ps,
    String? bm,
    String? mi,
    String? kn,
    String? kv,
    String? os,
    String? bn,
    String? li,
    String? vi,
    String? zh,
    String? eo,
    String? ha,
    String? tt,
    String? lb,
    String? ce,
    String? hu,
    String? it,
    String? tl,
    String? pl,
    String? sm,
    String? en,
    String? vo,
    String? el,
    String? sn,
    String? fr,
    String? cs,
    String? io,
    String? hi,
    String? et,
    String? pa,
    String? av,
    String? ko,
    String? bh,
    String? yi,
    String? sa,
    String? sl,
    String? hr,
    String? si,
    String? so,
    String? gn,
    String? ay,
    String? se,
    String? sd,
    String? af,
    String? ga,
    String? or,
    String? ia,
    String? ie,
    String? ug,
    String? nl,
    String? gv,
    String? qu,
    String? be,
    String? an,
    String? fo,
    String? hy,
    String? nv,
    String? bo,
    String? ascii,
    String? id,
    String? lv,
    String? ca,
    String? no,
    String? nn,
    String? ml,
    String? my,
    String? ne,
    String? he,
    String? cy,
    String? lo,
    String? jv,
    String? sv,
    String? mn,
    String? tg,
    String? kw,
    String? cv,
    String? az,
    String? oc,
    String? th,
    String? ru,
    String? ny,
    String? bs,
    String? st,
    String? ro,
    String? rm,
    String? ff,
    String? kk,
    String? uk,
    String? pt,
    String? tr,
    String? eu,
    String? ht,
    String? ka,
    String? ur,
  }) = _LocalNames;

  factory LocalNames.fromJson(Map<String, Object?> json) =>
      _$LocalNamesFromJson(json);
}
