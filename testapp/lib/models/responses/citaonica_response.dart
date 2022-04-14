import 'package:json_annotation/json_annotation.dart';

import '../other/radno_vrijeme.dart';

part 'citaonica_response.g.dart';

@JsonSerializable()
class CitaonicaResponse {
  int id;
  @JsonKey(name: 'naziv')
  String name;
  String mail;
  @JsonKey(name: 'brojTelefona')
  String phoneNumber;
  String adresa;
  @JsonKey(name: 'radnoVrijeme')
  List<RadnoVrijeme> radnoVrijeme;
  String vlasnik;
  String? opis;
  int? administratorId;

  CitaonicaResponse(
      {required this.name,
      required this.mail,
      required this.phoneNumber,
      required this.adresa,
      this.opis,
      this.administratorId,
      required this.radnoVrijeme,
      required this.vlasnik,
      required this.id});

  factory CitaonicaResponse.fromJson(Map<String, dynamic> json) =>
      _$CitaonicaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CitaonicaResponseToJson(this);
}
