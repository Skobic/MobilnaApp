import 'package:json_annotation/json_annotation.dart';
import 'package:testapp/models/responses/clanarina_response.dart';
import 'package:testapp/models/responses/karakteristike_sale_response.dart';

part 'grupna_sala_response.g.dart';

@JsonSerializable()
class GrupnaSalaResponse {
  int? id;
  @JsonKey(name: 'oznakaSale')
  String naziv;
  @JsonKey(name: 'kod')
  String qrKod;
  @JsonKey(name: 'kapacitet')
  int brojMjesta;
  String? opis;
  bool dostupno;
  //int statusId;
  List<ClanarinaResponse?> clanarine;
  List<KarakteristikeSaleResponse?> karakteristike;

  GrupnaSalaResponse(
      {this.id,
      required this.naziv,
      required this.qrKod,
      required this.brojMjesta,
      this.opis,
      required this.dostupno,
      required this.clanarine,
      required this.karakteristike});

  factory GrupnaSalaResponse.fromJson(Map<String, dynamic> json) =>
      _$GrupnaSalaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GrupnaSalaResponseToJson(this);
}
