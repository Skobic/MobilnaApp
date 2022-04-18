import 'package:json_annotation/json_annotation.dart';

part 'individualne_rezervacije_korisnika_response.g.dart';

@JsonSerializable()
class IndividualneRezervacijeKorisnikaResponse {
  int id;
  DateTime vrijemeVazenjaOd;
  DateTime vrijemeVazenjaDo;
  DateTime vrijemeRezervacije;
  DateTime? vrijemePotvrde;
  DateTime? vrijemeOtkazivanja;
  int korisnikId;
  int mjestoId;
  int mjestoBrojMjesta;
  String mjestoSalaOznakaSale;
  String mjestoSalaCitaonicaNaziv;

  IndividualneRezervacijeKorisnikaResponse(
      {required this.id,
      required this.vrijemeVazenjaOd,
      required this.vrijemeVazenjaDo,
      required this.vrijemeRezervacije,
      this.vrijemeOtkazivanja,
      this.vrijemePotvrde,
      required this.korisnikId,
      required this.mjestoId,
      required this.mjestoBrojMjesta,
      required this.mjestoSalaOznakaSale,
      required this.mjestoSalaCitaonicaNaziv});

  factory IndividualneRezervacijeKorisnikaResponse.fromJson(
          Map<String, dynamic> json) =>
      _$IndividualneRezervacijeKorisnikaResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$IndividualneRezervacijeKorisnikaResponseToJson(this);
}
