// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registracija_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistracijaRequest _$RegistracijaRequestFromJson(Map<String, dynamic> json) =>
    RegistracijaRequest(
      ime: json['ime'] as String,
      prezime: json['prezime'] as String,
      korisnickoIme: json['korisnickoIme'] as String,
      lozinka: json['lozinka'] as String,
      mail: json['mail'] as String,
    );

Map<String, dynamic> _$RegistracijaRequestToJson(
        RegistracijaRequest instance) =>
    <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'lozinka': instance.lozinka,
      'mail': instance.mail,
    };
