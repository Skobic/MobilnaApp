// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individualna_sala_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualnaSalaResponse _$IndividualnaSalaResponseFromJson(
        Map<String, dynamic> json) =>
    IndividualnaSalaResponse(
      id: json['id'] as int,
      naziv: json['oznakaSale'] as String,
      brojMjesta: json['kapacitet'] as int,
      opis: json['opis'] as String?,
      clanarine: (json['clanarine'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : ClanarinaResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      karakteristike: (json['karakteristike'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : KarakteristikeSaleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IndividualnaSalaResponseToJson(
        IndividualnaSalaResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oznakaSale': instance.naziv,
      'kapacitet': instance.brojMjesta,
      'opis': instance.opis,
      'clanarine': instance.clanarine,
      'karakteristike': instance.karakteristike,
    };
