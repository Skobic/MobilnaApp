// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_grupne_sale_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijeGrupneSaleRequest _$RezervacijeGrupneSaleRequestFromJson(
        Map<String, dynamic> json) =>
    RezervacijeGrupneSaleRequest(
      vrijemeVazenjaOd: const CustomDateTimeConverter()
          .fromJson(json['vrijemeVazenjaOd'] as String),
      vrijemeVazenjaDo: const CustomDateTimeConverter()
          .fromJson(json['vrijemeVazenjaDo'] as String),
      svrha: json['svrha'] as String?,
      brojOsoba: json['brojOsoba'] as int?,
    );

Map<String, dynamic> _$RezervacijeGrupneSaleRequestToJson(
        RezervacijeGrupneSaleRequest instance) =>
    <String, dynamic>{
      'vrijemeVazenjaOd':
          const CustomDateTimeConverter().toJson(instance.vrijemeVazenjaOd),
      'vrijemeVazenjaDo':
          const CustomDateTimeConverter().toJson(instance.vrijemeVazenjaDo),
      'svrha': instance.svrha,
      'brojOsoba': instance.brojOsoba,
    };
