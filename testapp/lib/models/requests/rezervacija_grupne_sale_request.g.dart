// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_grupne_sale_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijeGrupneSaleRequest _$RezervacijeGrupneSaleRequestFromJson(
        Map<String, dynamic> json) =>
    RezervacijeGrupneSaleRequest(
      vrijemeVazenjaOd: DateTime.parse(json['vrijemeVazenjaOd'] as String),
      vrijemeVazenjaDo: DateTime.parse(json['vrijemeVazenjaDo'] as String),
      svrha: json['svrha'] as String?,
      brojOsoba: json['brojOsoba'] as int?,
    );

Map<String, dynamic> _$RezervacijeGrupneSaleRequestToJson(
        RezervacijeGrupneSaleRequest instance) =>
    <String, dynamic>{
      'vrijemeVazenjaOd': instance.vrijemeVazenjaOd.toIso8601String(),
      'vrijemeVazenjaDo': instance.vrijemeVazenjaDo.toIso8601String(),
      'svrha': instance.svrha,
      'brojOsoba': instance.brojOsoba,
    };
