// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mjesto_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MjestoResponse _$MjestoResponseFromJson(Map<String, dynamic> json) =>
    MjestoResponse(
      pozicija: PozicijaXY.fromJson(json['pozicija'] as Map<String, dynamic>),
      velicina: (json['velicina'] as num).toDouble(),
      ugao: json['ugao'] as int,
      qrCode: json['kod'] as String,
      brojMjesta: json['brojMjesta'] as int,
      statusId: json['statusId'] as int,
      uticnica: json['uticnica'] as bool,
      id: json['id'] as int,
    );

Map<String, dynamic> _$MjestoResponseToJson(MjestoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brojMjesta': instance.brojMjesta,
      'kod': instance.qrCode,
      'velicina': instance.velicina,
      'ugao': instance.ugao,
      'uticnica': instance.uticnica,
      'statusId': instance.statusId,
      'pozicija': instance.pozicija,
    };
