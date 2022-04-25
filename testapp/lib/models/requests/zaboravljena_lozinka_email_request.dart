import 'package:json_annotation/json_annotation.dart';

part 'zaboravljena_lozinka_email_request.g.dart';

@JsonSerializable()
class ZaboravljenaLozinkaEmailRequest {
  String email;

  ZaboravljenaLozinkaEmailRequest({required this.email});

  factory ZaboravljenaLozinkaEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$ZaboravljenaLozinkaEmailRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$ZaboravljenaLozinkaEmailRequestToJson(this);
}
