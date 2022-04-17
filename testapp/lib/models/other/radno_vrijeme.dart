import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:testapp/convertors/custom_timeofday_convertor.dart';

part 'radno_vrijeme.g.dart';

@JsonSerializable()
@CustomTimeOfDayConverter()
class RadnoVrijeme {
  int dan;
  TimeOfDay? pocetak;
  TimeOfDay? kraj;

  RadnoVrijeme({required this.dan, required this.pocetak, required this.kraj});

  factory RadnoVrijeme.fromJson(Map<String, dynamic> json) =>
      _$RadnoVrijemeFromJson(json);
  Map<String, dynamic> toJson() => _$RadnoVrijemeToJson(this);
}
