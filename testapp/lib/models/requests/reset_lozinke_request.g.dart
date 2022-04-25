// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_lozinke_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetLozinkeRequest _$ResetLozinkeRequestFromJson(Map<String, dynamic> json) =>
    ResetLozinkeRequest(
      token: json['token'] as String,
      lozinka: json['lozinka'] as String,
    );

Map<String, dynamic> _$ResetLozinkeRequestToJson(
        ResetLozinkeRequest instance) =>
    <String, dynamic>{
      'token': instance.token,
      'lozinka': instance.lozinka,
    };
