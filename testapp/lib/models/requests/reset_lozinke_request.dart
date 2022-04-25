import 'package:json_annotation/json_annotation.dart';

part 'reset_lozinke_request.g.dart';

@JsonSerializable()
class ResetLozinkeRequest {
  String token;
  String lozinka;

  ResetLozinkeRequest({required this.token, required this.lozinka});

  factory ResetLozinkeRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetLozinkeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ResetLozinkeRequestToJson(this);
}
