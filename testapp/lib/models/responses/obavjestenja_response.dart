import 'package:json_annotation/json_annotation.dart';

part 'obavjestenja_response.g.dart';

@JsonSerializable()
class ObavjestenjaResponse {
  int id;
  String naslov;
  String sadrzaj;
  DateTime vrijeme;
  int citaonicaId;

  ObavjestenjaResponse(
      {required this.id,
      required this.naslov,
      required this.sadrzaj,
      required this.vrijeme,
      required this.citaonicaId});

  factory ObavjestenjaResponse.fromJson(Map<String, dynamic> json) =>
      _$ObavjestenjaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ObavjestenjaResponseToJson(this);
}
