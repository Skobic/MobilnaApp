// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obavjestenja_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObavjestenjaResponse _$ObavjestenjaResponseFromJson(
        Map<String, dynamic> json) =>
    ObavjestenjaResponse(
      id: json['id'] as int,
      naslov: json['naslov'] as String,
      sadrzaj: json['sadrzaj'] as String,
      vrijeme: DateTime.parse(json['vrijeme'] as String),
      supervizorId: json['supervizorId'] as int,
    );

Map<String, dynamic> _$ObavjestenjaResponseToJson(
        ObavjestenjaResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'vrijeme': instance.vrijeme.toIso8601String(),
      'supervizorId': instance.supervizorId,
    };
