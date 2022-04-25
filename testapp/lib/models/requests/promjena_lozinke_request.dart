import 'package:json_annotation/json_annotation.dart';

part 'promjena_lozinke_request.g.dart';

@JsonSerializable()
class PromjenaLozinkeRequest {
  String staraLozinka;
  String novaLozinka;

  PromjenaLozinkeRequest({
    required this.staraLozinka,
    required this.novaLozinka,
  });

  factory PromjenaLozinkeRequest.fromJson(Map<String, dynamic> json) =>
      _$PromjenaLozinkeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PromjenaLozinkeRequestToJson(this);
}
