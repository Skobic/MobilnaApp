import 'package:json_annotation/json_annotation.dart';

part 'grupne_rezervacije_korisnika_response.g.dart';

@JsonSerializable()
class GrupneRezervacijeKorisnikaResponse {
  int id;
  DateTime vrijemeVazenjaOd;
  DateTime vrijemeVazenjaDo;
  DateTime vrijemeRezervacije;
  DateTime? vrijemePotvrde;
  DateTime? vrijemeOtkazivanja;
  int korisnikId;
  int salaId;
  String salaOznakaSale;
  String salaCitaonicaNaziv;

  GrupneRezervacijeKorisnikaResponse(
      {required this.id,
      required this.vrijemeVazenjaOd,
      required this.vrijemeVazenjaDo,
      required this.vrijemeRezervacije,
      this.vrijemeOtkazivanja,
      this.vrijemePotvrde,
      required this.korisnikId,
      required this.salaId,
      required this.salaOznakaSale,
      required this.salaCitaonicaNaziv});

  factory GrupneRezervacijeKorisnikaResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GrupneRezervacijeKorisnikaResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GrupneRezervacijeKorisnikaResponseToJson(this);
}
