// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:testapp/PotvrdaDolaska.dart';

class Rezervacija {
  int id;

  int? idMjesta;
  int? idGrupneSale;
  DateTime odVrijeme;
  DateTime doVrijeme;
  DateTime? vrijemeKreiranja;
  DateTime? vrijemePotvrde;
  String sala;
  String citaonica;
  bool potvrdjena;

  int brojMjesta;

  Rezervacija(this.id, this.odVrijeme, this.doVrijeme, this.sala,
      this.citaonica, this.brojMjesta,this.potvrdjena);
}

//ovo je primjer kako da kreiras globalnu za rezervacije i kojem su formatu rezervacije
List<Rezervacija> listaRezervacijaTest = <Rezervacija>[
  Rezervacija(1, DateTime.parse("2021-07-20 08:49:04"),
      DateTime.parse("2021-07-20 09:55:04"), 'Sala 1', 'ETF', 16,true),
  Rezervacija(2, DateTime.parse("2021-07-19 14:13:34"),
      DateTime.parse("2021-07-19 12:00:54"), 'Sala 2', 'Paprikovac', 12,false),
  Rezervacija(3, DateTime.parse("2021-07-24 10:25:55"),
      DateTime.parse("2021-07-24 12:18:34"), 'Sala 1', 'ETF', 10,true),
  Rezervacija(4, DateTime.parse("2021-07-22 15:18:04"),
      DateTime.parse("2021-07-22 16:18:04"), 'Sala 1', 'Hodnici', 5,false),
  Rezervacija(5, DateTime.parse("2021-07-22 15:18:04"),
      DateTime.parse("2021-07-22 16:18:04"), 'Sala 1', 'Gradska čitaonica', -1,true),//-1 znaci da je grupna rezervacija
  Rezervacija(5, DateTime.parse("2022-03-21 09:00:00"),
      DateTime.parse("2022-03-21 11:55:00"), 'Sala 1', 'Gradska čitaonica', 22,true),
  Rezervacija(5, DateTime.parse("2022-03-18 04:18:04"),
      DateTime.parse("2022-03-18 05:40:12"), 'Sala 1', 'Paprikovac', -1,true),//-1 znaci da je grupna rezervacija
  Rezervacija(5, DateTime.parse("2022-03-18 01:35:14"),
      DateTime.parse("2022-03-18 02:55:04"), 'Sala 1', 'Paprikovac', 9,true),
];

Image _getImage(int param) {
  if (listaRezervacijaTest[param].citaonica == 'ETF') {
    return Image.asset('assets/images/etf.png');
  } else if (listaRezervacijaTest[param].citaonica == 'Paprikovac') {
    return Image.asset('assets/images/paprikovac.png');
  } else if (listaRezervacijaTest[param].citaonica == 'Gradska čitaonica') {
    return Image.asset('assets/images/narodna.png');
  }
  return Image.asset('assets/images/hodnici2.png');
}

DateTime defaultTime = DateTime.parse("2000-01-01 00:00:00");

Container _showRemainingTime(int param, DateTime remainingTime) {
  if (remainingTime != defaultTime) {
    if (remainingTime.day != 28) {
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
  return Container(
      margin: const EdgeInsets.only(top: 30, left: 5, right: 5),
      child: const Text('ISKORIŠTENA REZERVACIJA',
          style: TextStyle(
              color: Colors.black54,
              fontSize: 25,
              fontWeight: FontWeight.bold)));
}

Text _getTip(int param) {
  if (listaRezervacijaTest[param].brojMjesta == -1) {
    return const Text(
      'Rezervacija za grupu',
      style: TextStyle(
          color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
  return Text(
    'Oznaka mjesta: ${listaRezervacijaTest[param].brojMjesta}',
    style: const TextStyle(
        color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),
  );
}

class RezervacijePrikaz extends StatefulWidget {
  const RezervacijePrikaz({Key? key}) : super(key: key);

  @override
  _RezervacijePrikazState createState() => _RezervacijePrikazState();
}

//List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F'];

class _RezervacijePrikazState extends State<RezervacijePrikaz> {
  //List<int> colorCodes = <int>[600, 500, 400, 300, 200, 100];
  @override
  Widget build(BuildContext context) {
    double sirina = MediaQuery.of(context).size.width;
    DateTime sada = DateTime.now();
    listaRezervacijaTest.sort((a, b) => b.odVrijeme
        .subtract(
            Duration(days: sada.day, hours: sada.hour, minutes: sada.minute))
        .compareTo(a.odVrijeme.subtract(
            Duration(days: sada.day, hours: sada.hour, minutes: sada.minute))));

    return Scaffold(
      backgroundColor: const Color(0xFFD6F4F4),
      body: ListView.separated(
        //padding: const EdgeInsets.all(0.0),
        itemCount: listaRezervacijaTest.length,
        itemBuilder: (BuildContext context, int index) {
          DateTime rTime = DateTime.parse("2000-01-01 00:00:00");
          if (sada.isBefore(listaRezervacijaTest[index].odVrijeme)) {
            rTime = listaRezervacijaTest[index].odVrijeme.subtract(Duration(
                days: sada.day, hours: sada.hour, minutes: sada.minute));
          }
          return SafeArea(
            // padding: const EdgeInsets.only(left: 5, right: 5),
            child: SizedBox(
              height: 165,
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
                        margin: EdgeInsets.only(
                            left: 0.5 * sirina, bottom: 0, top: 10),
                        width: 0.5 * sirina,
                        child: Text(
                          'Lokacija: ${listaRezervacijaTest[index].citaonica}'
                          '\n'
                          'Datum: ${listaRezervacijaTest[index].odVrijeme.day < 10 ? '0${listaRezervacijaTest[index].odVrijeme.day}' : listaRezervacijaTest[index].odVrijeme.day}'
                          '.'
                          '${listaRezervacijaTest[index].odVrijeme.month < 10 ? '0${listaRezervacijaTest[index].odVrijeme.month}' : listaRezervacijaTest[index].odVrijeme.month}'
                          '.'
                          '${listaRezervacijaTest[index].odVrijeme.year}.'
                          '\n'
                          'Vrijeme: ${listaRezervacijaTest[index].odVrijeme.hour < 10 ? '0${listaRezervacijaTest[index].odVrijeme.hour}' : listaRezervacijaTest[index].odVrijeme.hour}'
                          ':'
                          '${listaRezervacijaTest[index].odVrijeme.minute < 10 ? '0${listaRezervacijaTest[index].odVrijeme.minute}' : listaRezervacijaTest[index].odVrijeme.minute}'
                          '-${listaRezervacijaTest[index].doVrijeme.hour < 10 ? '0${listaRezervacijaTest[index].doVrijeme.hour}' : listaRezervacijaTest[index].doVrijeme.hour}'
                          ':'
                          '${listaRezervacijaTest[index].doVrijeme.minute < 10 ? '0${listaRezervacijaTest[index].doVrijeme.minute}' : listaRezervacijaTest[index].doVrijeme.minute}'
                          '\n'
                          'Sala: ${listaRezervacijaTest[index].sala}',
                          overflow: TextOverflow.fade,
                          //maxLines: 7,
                          style: const TextStyle(
                              height: 1.1,
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0.0, left: 0.5 * sirina),
                        width: 0.5 * sirina,
                        child: _getTip(index),
                      ),
                    ]),
                  ),

                  /* Positioned(
                    top: 23,
                    left: 0.43 * sirina,
                    child: Text(
                      'Početak: ${listaRezervacijaTest[index].odVrijeme.day}'
                      '/'
                      '${listaRezervacijaTest[index].odVrijeme.month}'
                      ' u '
                      '${listaRezervacijaTest[index].odVrijeme.hour}'
                      ':'
                      '${listaRezervacijaTest[index].odVrijeme.minute}'
                      'h',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),*/
                  /* Positioned(
                    top: 41,
                    left: 0.43 * sirina,
                    child: Text(
                      'Kraj: ${listaRezervacijaTest[index].doVrijeme.day}'
                      '/'
                      '${listaRezervacijaTest[index].doVrijeme.month}'
                      ' u '
                      '${listaRezervacijaTest[index].doVrijeme.hour}'
                      ':'
                      '${listaRezervacijaTest[index].doVrijeme.minute}'
                      'h',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),*/
                  /*Positioned(
                    top: 59,
                    left: 0.43 * sirina,
                    child: Text(
                      'Sala: ${listaRezervacijaTest[index].sala}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),*/

                  /*Text(
                      'Oznaka mjesta: ${listaRezervacijaTest[index].brojMjesta}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),*/

                  Positioned(
                    left: 5,
                    top: 5,
                    bottom: 40,
                    width: 0.5 * sirina,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      //child: _getImage(index),
                      child: _showRemainingTime(index, rTime),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    width: 0.5 * sirina,
                    height: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFb3e7dc)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: const BorderSide(
                                        color: Color(0xFF4F9509), width: 3)))),

                        // color: const Color(0xFF23A729),
                        child: const Text('Potvrdi dolazak',
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFF4F9509))),
                        //textColor: Colors.white,
                        onPressed: () {
                          final now = DateTime.now();
                          DateTime endTime = listaRezervacijaTest[index]
                              .odVrijeme
                              .add(const Duration(minutes: 15));
                          DateTime startTime = listaRezervacijaTest[index]
                              .odVrijeme
                              .subtract(const Duration(minutes: 15));
                          bool uslov1 = now.isBefore(startTime);
                          bool uslov2 = now.isAfter(endTime);
                          if (uslov1 || uslov2) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Neispravno vrijeme'),
                                      content: Text(
                                          'Dolazak mozete potvrditi samo u intervalu od 15 minuta prije početka do 15 minuta nakon početka rezervacije !\n\n'
                                          'Za ovu rezervaciju:\n'
                                          '(Od ${startTime.hour < 10 ? '0${startTime.hour}' : startTime.hour}'
                                          ':${startTime.minute < 10 ? '0${startTime.minute}' : startTime.minute}'
                                          ':${startTime.second < 10 ? '0${startTime.second}' : startTime.second}'
                                          '       Do ${endTime.hour < 10 ? '0${endTime.hour}' : endTime.hour}'
                                          ':${endTime.minute < 10 ? '0${endTime.minute}' : endTime.minute}'
                                          ':${endTime.second < 10 ? '0${endTime.second}' : endTime.second})\n'
                                          'Datum: ${listaRezervacijaTest[index].odVrijeme.day < 10 ? '0${listaRezervacijaTest[index].odVrijeme.day}' : listaRezervacijaTest[index].odVrijeme.day}'
                                          '.'
                                          '${listaRezervacijaTest[index].odVrijeme.month < 10 ? '0${listaRezervacijaTest[index].odVrijeme.month}' : listaRezervacijaTest[index].odVrijeme.month}'
                                          '.'
                                          '${listaRezervacijaTest[index].odVrijeme.year}.\n'
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const PotvrdaDolaska()));
                          }
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    width: 0.5 * sirina,
                    height: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFb3e7dc)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: const BorderSide(
                                        color: Color(0xFFd50102), width: 3)))),
                        //  color: const Color(0xFFA72323),
                        child: const Text('Otkaži',
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFFd50102))),

                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Otkazivanje rezervacije'),
                              content: Text(
                                  'Da li ste sigurni da želite otkazati rezervaciju ${listaRezervacijaTest[index]}'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text(
                                            'Otkazivanje rezervacije'),
                                        content: const Text(
                                            'Uspjesno ste otkazali rezervaciju'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              listaRezervacijaTest.remove(
                                                  listaRezervacijaTest[index]);

                                              var nav = Navigator.of(context);
                                              //Navigator.pop(context, 'OK');
                                              nav.pop();
                                              nav.pop();
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          super.widget));
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
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
