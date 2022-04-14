import 'package:json_annotation/json_annotation.dart';
import 'package:testapp/models/responses/clanarina_response.dart';
import 'package:testapp/models/responses/karakteristike_sale_response.dart';

part 'individualna_sala_response.g.dart';

@JsonSerializable()
class IndividualnaSalaResponse {
  int id;
  @JsonKey(name: 'oznakaSale')
  String naziv;
  @JsonKey(name: 'kapacitet')
  int brojMjesta;
  String? opis;
  List<ClanarinaResponse?> clanarine;
  List<KarakteristikeSaleResponse?> karakteristike;

  IndividualnaSalaResponse(
      {required this.id,
      required this.naziv,
      required this.brojMjesta,
      this.opis,
      required this.clanarine,
      required this.karakteristike});

  factory IndividualnaSalaResponse.fromJson(Map<String, dynamic> json) =>
      _$IndividualnaSalaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$IndividualnaSalaResponseToJson(this);
}
