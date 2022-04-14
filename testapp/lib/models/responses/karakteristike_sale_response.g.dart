// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karakteristike_sale_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KarakteristikeSaleResponse _$KarakteristikeSaleResponseFromJson(
        Map<String, dynamic> json) =>
    KarakteristikeSaleResponse(
      karakteristikaId: json['karakteristikaId'] as int,
      karakteristikaNaziv: json['karakteristikaNaziv'] as String,
      detalji: json['detalji'] as String?,
    );

Map<String, dynamic> _$KarakteristikeSaleResponseToJson(
        KarakteristikeSaleResponse instance) =>
    <String, dynamic>{
      'karakteristikaId': instance.karakteristikaId,
      'karakteristikaNaziv': instance.karakteristikaNaziv,
      'detalji': instance.detalji,
    };
