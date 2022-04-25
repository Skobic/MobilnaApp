// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promjena_lozinke_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromjenaLozinkeRequest _$PromjenaLozinkeRequestFromJson(
        Map<String, dynamic> json) =>
    PromjenaLozinkeRequest(
      staraLozinka: json['staraLozinka'] as String,
      novaLozinka: json['novaLozinka'] as String,
    );

Map<String, dynamic> _$PromjenaLozinkeRequestToJson(
        PromjenaLozinkeRequest instance) =>
    <String, dynamic>{
      'staraLozinka': instance.staraLozinka,
      'novaLozinka': instance.novaLozinka,
    };
