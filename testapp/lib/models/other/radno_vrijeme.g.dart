// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radno_vrijeme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadnoVrijeme _$RadnoVrijemeFromJson(Map<String, dynamic> json) => RadnoVrijeme(
      dan: json['dan'] as int,
      pocetak:
          const CustomTimeOfDayConverter().fromJson(json['pocetak'] as String?),
      kraj: const CustomTimeOfDayConverter().fromJson(json['kraj'] as String?),
    );

Map<String, dynamic> _$RadnoVrijemeToJson(RadnoVrijeme instance) =>
    <String, dynamic>{
      'dan': instance.dan,
      'pocetak': const CustomTimeOfDayConverter().toJson(instance.pocetak),
      'kraj': const CustomTimeOfDayConverter().toJson(instance.kraj),
    };
