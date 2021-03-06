import 'package:json_annotation/json_annotation.dart';

import '../../convertors/custom_offset_convertor.dart';
import '../other/pozicijaXY.dart';

part 'mjesto_response.g.dart';

@JsonSerializable()
@CustomOffsetConverter()
class MjestoResponse {
  int id;
  @JsonKey(name: 'brojMjesta')
  int brojMjesta;
  @JsonKey(name: 'kod')
  String qrCode;
  double velicina;
  int ugao;
  bool uticnica;
  bool dostupno;
  @JsonKey(name: 'pozicija')
  PozicijaXY pozicija;
  bool? zauzeto;

  MjestoResponse(
      {required this.pozicija,
      required this.velicina,
      required this.ugao,
      required this.qrCode,
      required this.brojMjesta,
      required this.dostupno,
      required this.uticnica,
      required this.id,
      this.zauzeto});

  factory MjestoResponse.fromJson(Map<String, dynamic> json) =>
      _$MjestoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MjestoResponseToJson(this);
}
