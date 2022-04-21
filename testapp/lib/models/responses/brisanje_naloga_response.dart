import 'package:json_annotation/json_annotation.dart';

part 'brisanje_naloga_response.g.dart';

@JsonSerializable()
class BrisanjeNalogaResponse {
  String lozinka;

  BrisanjeNalogaResponse({required this.lozinka});

  factory BrisanjeNalogaResponse.fromJson(Map<String, dynamic> json) =>
      _$BrisanjeNalogaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BrisanjeNalogaResponseToJson(this);
}
