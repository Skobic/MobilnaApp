import 'package:json_annotation/json_annotation.dart';
import 'package:testapp/convertors/custom_datetime_convertor.dart';

part 'rezervacija_grupne_sale_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class RezervacijeGrupneSaleRequest {
  DateTime vrijemeVazenjaOd;
  DateTime vrijemeVazenjaDo;
  String? svrha;
  int? brojOsoba;

  RezervacijeGrupneSaleRequest(
      {required this.vrijemeVazenjaOd,
      required this.vrijemeVazenjaDo,
      this.svrha,
      this.brojOsoba});

  factory RezervacijeGrupneSaleRequest.fromJson(Map<String, dynamic> json) =>
      _$RezervacijeGrupneSaleRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RezervacijeGrupneSaleRequestToJson(this);
}
