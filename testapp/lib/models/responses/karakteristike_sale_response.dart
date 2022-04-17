import 'package:json_annotation/json_annotation.dart';

part 'karakteristike_sale_response.g.dart';

@JsonSerializable()
class KarakteristikeSaleResponse {
  int karakteristikaId;
  String karakteristikaNaziv;
  String? detalji;

  KarakteristikeSaleResponse(
      {required this.karakteristikaId,
      required this.karakteristikaNaziv,
      this.detalji});

  factory KarakteristikeSaleResponse.fromJson(Map<String, dynamic> json) =>
      _$KarakteristikeSaleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$KarakteristikeSaleResponseToJson(this);
}
