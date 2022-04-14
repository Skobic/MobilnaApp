import 'package:json_annotation/json_annotation.dart';

part 'clanarina_response.g.dart';

@JsonSerializable()
class ClanarinaResponse {
  String vremenskiPeriodNaziv;
  double cijena;

  ClanarinaResponse({
    required this.cijena,
    required this.vremenskiPeriodNaziv,
  });

  factory ClanarinaResponse.fromJson(Map<String, dynamic> json) =>
      _$ClanarinaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ClanarinaResponseToJson(this);
}
