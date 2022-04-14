// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clanarina_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClanarinaResponse _$ClanarinaResponseFromJson(Map<String, dynamic> json) =>
    ClanarinaResponse(
      cijena: (json['cijena'] as num).toDouble(),
      vremenskiPeriodNaziv: json['vremenskiPeriodNaziv'] as String,
    );

Map<String, dynamic> _$ClanarinaResponseToJson(ClanarinaResponse instance) =>
    <String, dynamic>{
      'vremenskiPeriodNaziv': instance.vremenskiPeriodNaziv,
      'cijena': instance.cijena,
    };
