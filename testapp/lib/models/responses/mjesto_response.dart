import '../other/pozicijaXY.dart';

class MjestoResponse {
  int id;

  int brojMjesta;
  String qrCode;
  int velicina;
  int ugao;
  bool uticnica;
  int statusId;
  PozicijaXY pozicija;

  MjestoResponse(
      {required this.pozicija,
      required this.velicina,
      required this.ugao,
      required this.qrCode,
      required this.brojMjesta,
      required this.statusId,
      required this.uticnica,
      required this.id});
}
