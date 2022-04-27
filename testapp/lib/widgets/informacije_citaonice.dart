import 'package:flutter/material.dart';
import 'package:testapp/models/responses/citaonica_response.dart';
import 'package:testapp/pages/obavjestenje_page.dart';

import '../constants/config.dart';
import '../models/other/radno_vrijeme.dart';

class InformacijeCitaonice extends StatelessWidget {
  final CitaonicaResponse citaonicaData;
  const InformacijeCitaonice({Key? key, required this.citaonicaData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Naziv',
                //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                // ),
                // SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 18),
                    children: <TextSpan>[
                      const TextSpan(
                          text: 'Adresa: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 63, 63, 63))),
                      TextSpan(
                          text: citaonicaData.adresa,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 63, 63, 63))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 18),
                    children: <TextSpan>[
                      const TextSpan(
                          text: 'Telefon: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 63, 63, 63))),
                      TextSpan(
                          text: citaonicaData.phoneNumber,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 63, 63, 63))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      const TextSpan(
                          text: 'E-mail: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 63, 63, 63))),
                      TextSpan(
                          text: citaonicaData.mail,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 63, 63, 63))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Opis: ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 63, 63, 63))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                          (citaonicaData.opis != null)
                              ? citaonicaData.opis!
                              : '',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Radno vrijeme: ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 63, 63, 63))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(formatiranoRadnoVrijeme(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal)),
                    ),
                  ],
                ),
                // RichText(
                //   text: TextSpan(
                //     style: const TextStyle(
                //         fontSize: 18, fontWeight: FontWeight.bold),
                //     children: <TextSpan>[
                //       const TextSpan(
                //           text: 'E-mail: ',
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               color: Color.fromARGB(255, 63, 63, 63))),
                //       TextSpan(
                //           text: citaonicaData.mail,
                //           style: const TextStyle(
                //               fontWeight: FontWeight.normal,
                //               color: Color.fromARGB(255, 63, 63, 63))),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Align(
          child: IconButton(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(3.0),
            color: podnaslovBoja,
            splashRadius: 27,
            iconSize: 45,
            icon: const Icon(Icons.circle_notifications_outlined),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const PrikazObavjestenja()));
            },
          ),
        )
      ],
    );
  }

  String formatiranoRadnoVrijeme() {
    final dani = {
      0: 'pon',
      1: 'uto',
      2: 'sri',
      3: 'čet',
      4: 'pet',
      5: 'sub',
      6: 'ned'
    };
    String ispis = '';
    List<int> pomocnaLista = <int>[];
    int i = 0;
    while (i < citaonicaData.radnoVrijeme.length) {
      print('test');
      for (int j = i + 1; j < citaonicaData.radnoVrijeme.length; j++) {
        if (citaonicaData.radnoVrijeme[j].pocetak ==
                citaonicaData.radnoVrijeme[i].pocetak &&
            citaonicaData.radnoVrijeme[j].kraj ==
                citaonicaData.radnoVrijeme[i].kraj &&
            (citaonicaData.radnoVrijeme[j].dan -
                    citaonicaData.radnoVrijeme[j - 1].dan) ==
                1) {
          pomocnaLista.add(j);
        } else {
          break;
        }
      }
      if (pomocnaLista.isNotEmpty) {
        String temp = '';
        if (ispis.isNotEmpty) {
          temp = '';
        }
        ispis = ispis +
            temp +
            dani[i].toString() +
            '-' +
            dani[pomocnaLista.last].toString() +
            ' : ' +
            citaonicaData.radnoVrijeme[i].pocetak!.hour
                .toString()
                .padLeft(2, '0') +
            ':' +
            citaonicaData.radnoVrijeme[i].pocetak!.minute
                .toString()
                .padLeft(2, '0') +
            '-' +
            citaonicaData.radnoVrijeme[i].kraj!.hour
                .toString()
                .padLeft(2, '0') +
            ':' +
            citaonicaData.radnoVrijeme[i].kraj!.minute
                .toString()
                .padLeft(2, '0') +
            '\n';
        i = pomocnaLista.last + 1;
        pomocnaLista.clear();
      } else {
        String temp = '';
        if (ispis.isNotEmpty) {
          temp = '';
        }
        ispis = ispis +
            temp +
            dani[i].toString() +
            ' : ' +
            citaonicaData.radnoVrijeme[i].pocetak!.hour
                .toString()
                .padLeft(2, '0') +
            ':' +
            citaonicaData.radnoVrijeme[i].pocetak!.minute
                .toString()
                .padLeft(2, '0') +
            '-' +
            citaonicaData.radnoVrijeme[i].kraj!.hour
                .toString()
                .padLeft(2, '0') +
            ':' +
            citaonicaData.radnoVrijeme[i].kraj!.minute
                .toString()
                .padLeft(2, '0') +
            '\n';
        pomocnaLista.clear();
        i++;
      }
    }
    return ispis;
  }
}
