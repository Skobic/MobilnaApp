import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:testapp/models/other/argumenti_grupne_potvrd_dolaska.dart';
import 'package:testapp/models/responses/grupne_rezervacije_korisnika_response.dart';
import 'package:testapp/models/responses/individualne_rezervacije_korisnika_response.dart';
import 'package:testapp/pocetna_strana.dart';

DateTime defaultTime = DateTime.parse("2000-01-01 00:00:00");

Container _showRemainingTime(DateTime remainingTime, bool otkazana,
    bool potvrdjena, DateTime remainingPotvrdaTime) {
  if (remainingTime != defaultTime && !otkazana && !potvrdjena) {
    if (remainingTime.day < 25) {
      return Container(
          child: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text('DO POČETKA:',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 25,
                      fontWeight: FontWeight.bold))),
          Container(
            child: Text(
                '${remainingTime.day != 1 ? '${remainingTime.day} dana' : '${remainingTime.day} dan'}\n'
                '${remainingTime.hour}h'
                ' i ${remainingTime.minute}min',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ));
    } else {
      return Container(
          child: Column(
        children: <Widget>[
          Center(
            child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text('DO POČETKA:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                        fontWeight: FontWeight.bold))),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
                '${remainingTime.hour == 0 ? '' : '${remainingTime.hour}h i '}'
                '${remainingTime.minute}min',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ));
    }
  }

  if (remainingPotvrdaTime != defaultTime && !otkazana && !potvrdjena) {
    if (remainingTime.day < 25) {
      return Container(
          child: Column(
        children: <Widget>[
          Center(
            child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text('ROK ZA POTVRDU DOLASKA:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
                '${remainingPotvrdaTime.minute == 0 ? '' : '${remainingPotvrdaTime.minute}min i '}'
                '${remainingPotvrdaTime.second}sec',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ));
    }
  }

  if (otkazana) {
    return Container(
        margin: const EdgeInsets.only(top: 30, left: 5, right: 5),
        child: const Text('OTKAZANA REZERVACIJA',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromARGB(255, 211, 58, 47),
                fontSize: 23,
                fontWeight: FontWeight.bold)));
  }
  if (potvrdjena) {
    return Container(
        margin: const EdgeInsets.only(top: 30, left: 5, right: 5),
        child: Text('ISKORIŠTENA REZERVACIJA',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.green[800],
                fontSize: 23,
                fontWeight: FontWeight.bold)));
  }

  return Container(
      margin: const EdgeInsets.only(top: 30, left: 5, right: 5),
      child: const Text('NEISKORIŠTENA REZERVACIJA',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 23,
              fontWeight: FontWeight.bold)));
}

class GrupnaRezervacijaKorisnikaCard extends StatelessWidget {
  final GrupneRezervacijeKorisnikaResponse grupRezKorData;

  int index;
  int idSale;

  final Function(int, int) funkcijaBrisanja;
  GrupnaRezervacijaKorisnikaCard({
    Key? key,
    required this.grupRezKorData,
    required this.index,
    required this.idSale,
    required this.funkcijaBrisanja,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sirina = MediaQuery.of(context).size.width;

    bool otkazana = false;
    bool potvrdjena = false;
    if (grupRezKorData.vrijemeOtkazivanja != null ||
        grupRezKorData.vrijemeVazenjaDo.isBefore(DateTime.now()) ||
        grupRezKorData.vrijemePotvrde != null) {
      grupRezKorData.vrijemeVazenjaOd =
          grupRezKorData.vrijemeVazenjaOd.subtract(const Duration(days: 15));
    }

    if (grupRezKorData.vrijemeOtkazivanja != null) {
      otkazana = true;
    }
    if (grupRezKorData.vrijemePotvrde != null) {
      potvrdjena = true;
    }

    DateTime sada = DateTime.now();
    DateTime rTime = DateTime.parse("2000-01-01 00:00:00");
    if (sada.isBefore(grupRezKorData.vrijemeVazenjaOd)) {
      rTime = grupRezKorData.vrijemeVazenjaOd.subtract(
          Duration(days: sada.day, hours: sada.hour, minutes: sada.minute));
    }
    DateTime rPotvrdaTime = DateTime.parse("2000-01-01 00:00:00");
    DateTime krajnjeVrijemePotvrde =
        grupRezKorData.vrijemeVazenjaOd.add(const Duration(minutes: 15));
    if (sada.isBefore(krajnjeVrijemePotvrde)) {
      rPotvrdaTime = krajnjeVrijemePotvrde.subtract(Duration(
          days: sada.day,
          hours: sada.hour,
          minutes: sada.minute,
          seconds: sada.second));
    }

    return Container(
      margin: EdgeInsets.only(left: sirina * 0.015, right: sirina * 0.015),
      height: 150,
      //width: 210,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF78AECB),
                  Color(0xFF78AECB),
                ],
              ),
            ),
            //color: Colors.blue[400],
            /*child: Center(
                        child: Text(
                            'Rezervacija ${listaRezervacijaTest[index].citaonica}')),*/
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 35),
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 0.5 * sirina, bottom: 0, top: 10),
                width: 0.5 * sirina,
                child: Text(
                  'Lokacija: ${grupRezKorData.salaCitaonicaNaziv}'
                  '\n'
                  'Datum: ${grupRezKorData.vrijemeVazenjaOd.day < 10 ? '0${grupRezKorData.vrijemeVazenjaOd.day}' : grupRezKorData.vrijemeVazenjaOd.day}'
                  '.'
                  '${grupRezKorData.vrijemeVazenjaOd.month < 10 ? '0${grupRezKorData.vrijemeVazenjaOd.month}' : grupRezKorData.vrijemeVazenjaOd.month}'
                  '.'
                  '${grupRezKorData.vrijemeVazenjaOd.year}.'
                  '\n'
                  'Vrijeme: ${grupRezKorData.vrijemeVazenjaOd.hour < 10 ? '0${grupRezKorData.vrijemeVazenjaOd.hour}' : grupRezKorData.vrijemeVazenjaOd.hour}'
                  ':'
                  '${grupRezKorData.vrijemeVazenjaOd.minute < 10 ? '0${grupRezKorData.vrijemeVazenjaOd.minute}' : grupRezKorData.vrijemeVazenjaOd.minute}'
                  '-${grupRezKorData.vrijemeVazenjaDo.hour < 10 ? '0${grupRezKorData.vrijemeVazenjaDo.hour}' : grupRezKorData.vrijemeVazenjaDo.hour}'
                  ':'
                  '${grupRezKorData.vrijemeVazenjaDo.minute < 10 ? '0${grupRezKorData.vrijemeVazenjaDo.minute}' : grupRezKorData.vrijemeVazenjaDo.minute}'
                  '\n'
                  'Oznaka sale: ${grupRezKorData.salaOznakaSale}\n',
                  overflow: TextOverflow.fade,
                  //maxLines: 7,
                  style: const TextStyle(
                      height: 1.1,
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          ),
          Positioned(
            left: 5,
            top: 5,
            bottom: 40,
            width: 0.5 * sirina,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              //child: _getImage(index),
              child:
                  _showRemainingTime(rTime, otkazana, potvrdjena, rPotvrdaTime),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            width: 0.485 * sirina,
            height: 35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFb3e7dc)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: const BorderSide(
                                color: Color(0xFF4F9509), width: 3)))),

                // color: const Color(0xFF23A729),
                child: const Text('Potvrdi dolazak',
                    style: TextStyle(fontSize: 20, color: Color(0xFF4F9509))),
                //textColor: Colors.white,
                onPressed: () {
                  final now = DateTime.now();
                  DateTime endTime = grupRezKorData.vrijemeVazenjaOd
                      .add(const Duration(minutes: 15));
                  DateTime startTime = grupRezKorData.vrijemeVazenjaOd;
                  bool uslov1 = now.isBefore(startTime);
                  bool uslov2 = now.isAfter(endTime);
                  if (otkazana) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Otkazana rezervacija'),
                              content: const Text(
                                  'Ova rezervacija je otkazana, ne možete potvrditi dolazak !'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  }
                  if (potvrdjena) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Potvrdjena rezervacija'),
                              content: const Text(
                                  'Dolazak na ovu rezervaciju je već potvrdjen, ne možete ponovo potvrditi dolazak !'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  }
                  if (!otkazana && !potvrdjena) {
                    if (uslov1 || uslov2) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Neispravno vrijeme'),
                                content: Text(
                                    'Dolazak mozete potvrditi samo u intervalu od početka rezervacija do 15 minuta nakon početka rezervacije !\n\n'
                                    'Za ovu rezervaciju:\n'
                                    '(Od ${startTime.hour < 10 ? '0${startTime.hour}' : startTime.hour}'
                                    ':${startTime.minute < 10 ? '0${startTime.minute}' : startTime.minute}'
                                    ':${startTime.second < 10 ? '0${startTime.second}' : startTime.second}'
                                    '       Do ${endTime.hour < 10 ? '0${endTime.hour}' : endTime.hour}'
                                    ':${endTime.minute < 10 ? '0${endTime.minute}' : endTime.minute}'
                                    ':${endTime.second < 10 ? '0${endTime.second}' : endTime.second})\n'
                                    'Datum: ${grupRezKorData.vrijemeVazenjaDo.day < 10 ? '0${grupRezKorData.vrijemeVazenjaDo.day}' : grupRezKorData.vrijemeVazenjaDo.day}'
                                    '.'
                                    '${grupRezKorData.vrijemeVazenjaDo.month < 10 ? '0${grupRezKorData.vrijemeVazenjaDo.month}' : grupRezKorData.vrijemeVazenjaDo.month}'
                                    '.'
                                    '${grupRezKorData.vrijemeVazenjaDo.year}.\n'
                                    /*'before:${uslov1}\n'
                                          'after:${uslov2}'*/
                                    ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    } else {
                      navigatorKey.currentState!.pushNamed(
                          'individualna_potvrda_dolaska',
                          arguments: ArgumentiGrupnePotvrdeDolaska(
                              idSale: grupRezKorData.salaId,
                              idRezervacije: grupRezKorData.id));
                    }
                  }
                },
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            width: 0.485 * sirina,
            height: 35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFb3e7dc)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: const BorderSide(
                                color: Color(0xFFd50102), width: 3)))),
                //  color: const Color(0xFFA72323),
                child: const Text('Otkaži',
                    style: TextStyle(fontSize: 20, color: Color(0xFFd50102))),

                onPressed: () {
                  if (otkazana) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Otkazana rezervacija'),
                              content: const Text(
                                  'Ova rezervacija je već otkazana, ne možete je ponovo otkazati !'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  }
                  if (potvrdjena &&
                      DateTime.now()
                          .isBefore(grupRezKorData.vrijemeVazenjaDo)) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Otkazivanje rezervacije'),
                        content: const Text(
                            'Da li ste sigurni da želite otkazati rezervaciju koju ste već potvrdili?\n'
                            'Ako to učinite morate napustiti mjesto i pokupiti svoje stvari !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Otkazivanje rezervacije'),
                                  content: const Text(
                                      'Uspjesno ste otkazali rezervaciju'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        funkcijaBrisanja(index, idSale);
                                        var nav = Navigator.of(context);
                                        //Navigator.pop(context, 'OK');
                                        nav.pop();
                                        nav.pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text('Da'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Ne'),
                            child: const Text('Ne'),
                          ),
                        ],
                      ),
                    );
                  } else if (potvrdjena &&
                      !DateTime.now()
                          .isBefore(grupRezKorData.vrijemeVazenjaDo)) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Iskorištena rezervacija'),
                              content: const Text(
                                  'Ova rezervacija je već u potpunosti iskorištena i istekla je, ne možete je više otkazati !'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  }
                  if (!otkazana &&
                      !potvrdjena &&
                      DateTime.now()
                          .isBefore(grupRezKorData.vrijemeVazenjaOd)) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Otkazivanje rezervacije'),
                        content: const Text(
                            'Da li ste sigurni da želite otkazati rezervaciju?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Otkazivanje rezervacije'),
                                  content: const Text(
                                      'Uspjesno ste otkazali rezervaciju'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        funkcijaBrisanja(index, idSale);
                                        var nav = Navigator.of(context);
                                        //Navigator.pop(context, 'OK');
                                        nav.pop();
                                        nav.pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text('Da'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Ne'),
                            child: const Text('Ne'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (!otkazana &&
                      !potvrdjena &&
                      !DateTime.now()
                          .isBefore(grupRezKorData.vrijemeVazenjaOd)) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Neiskorištena rezervacija'),
                              content: const Text(
                                  'Ova rezervacija je već istekla, ne možete je više otkazati !'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
