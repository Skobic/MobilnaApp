// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grupne_rezervacije_korisnika_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrupneRezervacijeKorisnikaResponse _$GrupneRezervacijeKorisnikaResponseFromJson(
        Map<String, dynamic> json) =>
    GrupneRezervacijeKorisnikaResponse(
      id: json['id'] as int,
      vrijemeVazenjaOd: DateTime.parse(json['vrijemeVazenjaOd'] as String),
      vrijemeVazenjaDo: DateTime.parse(json['vrijemeVazenjaDo'] as String),
      vrijemeRezervacije: DateTime.parse(json['vrijemeRezervacije'] as String),
      vrijemeOtkazivanja: json['vrijemeOtkazivanja'] == null
          ? null
          : DateTime.parse(json['vrijemeOtkazivanja'] as String),
      vrijemePotvrde: json['vrijemePotvrde'] == null
          ? null
          : DateTime.parse(json['vrijemePotvrde'] as String),
      korisnikId: json['korisnikId'] as int,
      salaId: json['salaId'] as int,
      salaOznakaSale: json['salaOznakaSale'] as String,
      salaCitaonicaNaziv: json['salaCitaonicaNaziv'] as String,
    );

Map<String, dynamic> _$GrupneRezervacijeKorisnikaResponseToJson(
        GrupneRezervacijeKorisnikaResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vrijemeVazenjaOd': instance.vrijemeVazenjaOd.toIso8601String(),
      'vrijemeVazenjaDo': instance.vrijemeVazenjaDo.toIso8601String(),
      'vrijemeRezervacije': instance.vrijemeRezervacije.toIso8601String(),
      'vrijemePotvrde': instance.vrijemePotvrde?.toIso8601String(),
      'vrijemeOtkazivanja': instance.vrijemeOtkazivanja?.toIso8601String(),
      'korisnikId': instance.korisnikId,
      'salaId': instance.salaId,
      'salaOznakaSale': instance.salaOznakaSale,
      'salaCitaonicaNaziv': instance.salaCitaonicaNaziv,
    };
