import 'package:json_annotation/json_annotation.dart';

part 'registracija_request.g.dart';

@JsonSerializable()
class RegistracijaRequest {
  String ime;
  String prezime;
  String korisnickoIme;
  String lozinka;
  String mail;

  RegistracijaRequest(
      {required this.ime,
      required this.prezime,
      required this.korisnickoIme,
      required this.lozinka,
      required this.mail});

  factory RegistracijaRequest.fromJson(Map<String, dynamic> json) =>
      _$RegistracijaRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegistracijaRequestToJson(this);
}
