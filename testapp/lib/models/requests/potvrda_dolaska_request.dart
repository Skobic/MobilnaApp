import 'package:json_annotation/json_annotation.dart';

part 'potvrda_dolaska_request.g.dart';

@JsonSerializable()
class PotvrdaDolaskaRequest {
  String kod;

  PotvrdaDolaskaRequest({required this.kod});

  factory PotvrdaDolaskaRequest.fromJson(Map<String, dynamic> json) =>
      _$PotvrdaDolaskaRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PotvrdaDolaskaRequestToJson(this);
}
