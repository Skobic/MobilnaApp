import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_mjesta_response.g.dart';

@JsonSerializable()
class RezervacijaMjestaResponse {
  int id;
  DateTime vrijemeVazenjaOd;
  DateTime vrijemeVazenjaDo;
  DateTime vrijemeRezervacije;
  DateTime? vrijemePotvrde;
  DateTime? vrijemeOtkazivanja;
  int korisnikId;

  RezervacijaMjestaResponse(
      {required this.id,
      required this.vrijemeVazenjaOd,
      required this.vrijemeVazenjaDo,
      required this.vrijemeRezervacije,
      this.vrijemeOtkazivanja,
      this.vrijemePotvrde,
      required this.korisnikId});

  factory RezervacijaMjestaResponse.fromJson(Map<String, dynamic> json) =>
      _$RezervacijaMjestaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RezervacijaMjestaResponseToJson(this);
}
