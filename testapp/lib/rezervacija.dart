//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rezervacija {
  int id;
  DateTime odVrijeme;
  DateTime doVrijeme;
  String? datum;
  String sala;
  String citaonica;
  String? aktivna;

  Rezervacija(
      this.id, this.odVrijeme, this.doVrijeme, this.sala, this.citaonica) {
    datum = '${doVrijeme.day}' '/' '${doVrijeme.month}' '/' '${doVrijeme.year}';
  }
}

List<Rezervacija> listaRezervacija = <
    Rezervacija>[]; /*= <Rezervacija>[
  Rezervacija(1, DateTime.parse("2021-07-20 15:18:04Z"),
      DateTime.parse("2021-07-20 16:18:04Z"), 'Sala 1', 'ETF'),
  Rezervacija(2, DateTime.parse("2021-07-19 14:13:34Z"),
      DateTime.parse("2021-07-19 12:00:54Z"), 'Sala 2', 'Paprikovac'),
  Rezervacija(3, DateTime.parse("2021-07-24 10:25:55Z"),
      DateTime.parse("2021-07-24 12:18:34Z"), 'Sala 1', 'ETF'),
  Rezervacija(4, DateTime.parse("2021-07-22 15:18:04Z"),
      DateTime.parse("2021-07-22 16:18:04Z"), 'Sala 1', 'Hodnici'),
];*/

class Rezervisanje extends StatelessWidget {
  const Rezervisanje({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => {
            listaRezervacija.add(Rezervacija(
                1,
                DateTime.parse("2021-07-20 15:18:04Z"),
                DateTime.parse("2021-07-20 16:18:04Z"),
                'Sala 1',
                'ETF'))
          },
          child: Container(
            color: Colors.grey[200],
            height: 200,
            width: 400,
            child: const Text(
              'ETF rezervacija',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => {
            listaRezervacija.add(Rezervacija(
                2,
                DateTime.parse("2021-07-19 14:13:34Z"),
                DateTime.parse("2021-07-19 12:00:54Z"),
                'Sala 2',
                'Paprikovac'))
          },
          child: Container(
            color: Colors.grey[200],
            height: 200,
            width: 400,
            child: const Text(
              'Paprikovac rezervacija',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => {
            listaRezervacija.add(Rezervacija(
                4,
                DateTime.parse("2021-07-22 15:18:04Z"),
                DateTime.parse("2021-07-22 16:18:04Z"),
                'Sala 1',
                'Hodnici'))
          },
          child: Container(
            color: Colors.grey[200],
            height: 200,
            width: 400,
            child: const Text(
              'Hodnici rezervacija',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
