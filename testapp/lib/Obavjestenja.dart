// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Obavjestenje {
  String naslovObavjestenja;
  String textObavjestenja;
  DateTime vrijemeObavjestenja;
  int tip;
  Obavjestenje({
    required this.tip,
    required this.naslovObavjestenja,
    required this.textObavjestenja,
    required this.vrijemeObavjestenja,
  });
}

List<Obavjestenje> listaObavjestenja = <Obavjestenje>[
  Obavjestenje(
      tip: 1,
      naslovObavjestenja: 'Obavjestenje',
      textObavjestenja: 'Tekst 1',
      vrijemeObavjestenja: DateTime.now()),
  Obavjestenje(
      tip: 2,
      naslovObavjestenja: 'Promjena radnog vremena',
      textObavjestenja:
          'Citaonica radi od 8 do 10, neki tekst bla bla 123 proba test tekstas sdashdasjhasj ',
      vrijemeObavjestenja: DateTime.utc(2022, 2, 3, 20, 30)),
  Obavjestenje(
      tip: 3,
      naslovObavjestenja: 'Promjena radnog vremena',
      textObavjestenja: 'Citaonica radi od 8 do 18',
      vrijemeObavjestenja: DateTime.utc(2022, 12, 3, 20, 35)),
  Obavjestenje(
      tip: 1,
      naslovObavjestenja: 'Promjena radnog vremena',
      textObavjestenja:
          'Citaonica radi od 8 do 10, neki tekst bla bla 123 proba test tekstas sdashdasjhasj ',
      vrijemeObavjestenja: DateTime.utc(2022, 2, 3, 20, 30)),
  Obavjestenje(
      tip: 1,
      naslovObavjestenja: 'Promjena radnog vremena',
      textObavjestenja:
          'Citaonica radi od 8 do 10, neki tekst bla bla 123 proba test tekstas sdashdasjhasj ',
      vrijemeObavjestenja: DateTime.utc(2022, 2, 3, 20, 30)),
  Obavjestenje(
      tip: 3,
      naslovObavjestenja: 'Promjena radnog vremena',
      textObavjestenja:
          'Citaonica radi od 8 do 10, neki tekst bla bla 123 proba test tekstas sdashdasjhasj ',
      vrijemeObavjestenja: DateTime.utc(2022, 2, 3, 20, 30)),
  Obavjestenje(
      tip: 3,
      naslovObavjestenja: 'Promjena radnog vremena',
      textObavjestenja:
          'Citaonica radi od 8 do 10, neki tekst bla bla 123 proba test tekstas sdashdasjhasj ',
      vrijemeObavjestenja: DateTime.utc(2022, 2, 3, 20, 30)),
  Obavjestenje(
      tip: 2,
      naslovObavjestenja: 'Promjena radnog vremena',
      textObavjestenja:
          'Citaonica radi od 8 do 10, neki tekst bla bla 123 proba test tekstas sdashdasjhasj ',
      vrijemeObavjestenja: DateTime.utc(2022, 2, 3, 20, 30)),
];

ListTile _getWidget(int param) {
  if (listaObavjestenja[param].tip == 1) {
    return ListTile(
      leading: Icon(Icons.alarm, color: Colors.red[700], size: 45),
      title: Text(' ${listaObavjestenja[param].naslovObavjestenja}'),
      subtitle: Text(' ${listaObavjestenja[param].textObavjestenja}'),
      trailing: Text(
          ' ${listaObavjestenja[param].vrijemeObavjestenja.toString().substring(0, 16)}'),
    );
  } else if (listaObavjestenja[param].tip == 2) {
    return ListTile(
      leading:
          Icon(Icons.lock_clock_outlined, color: Colors.red[700], size: 45),
      title: Text(' ${listaObavjestenja[param].naslovObavjestenja}'),
      subtitle: Text(' ${listaObavjestenja[param].textObavjestenja}'),
      trailing: Text(
          ' ${listaObavjestenja[param].vrijemeObavjestenja.toString().substring(0, 16)}'),
    );
  }
  return ListTile(
    leading: Icon(
      Icons.announcement_outlined,
      color: Colors.red[700],
      size: 45,
    ),
    title: Text(' ${listaObavjestenja[param].naslovObavjestenja}'),
    subtitle: Text(' ${listaObavjestenja[param].textObavjestenja}'),
    trailing: Text(
        ' ${listaObavjestenja[param].vrijemeObavjestenja.toString().substring(0, 16)}'),
  );
}

class Obavjestenja extends StatefulWidget {
  const Obavjestenja({Key? key}) : super(key: key);

  @override
  _ObavjestenjaState createState() => _ObavjestenjaState();
}

class _ObavjestenjaState extends State<Obavjestenja> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: const Text('Obavjestenja'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: listaObavjestenja.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            child: Stack(
              children: <Widget>[
                Card(
                  color: Colors.green[100],
                  child: _getWidget(index),
                  /*ListTile(
                    //leading: getIcon(listaObavjestenja[index].tip),
                    title:
                        Text(' ${listaObavjestenja[index].naslovObavjestenja}'),
                    subtitle:
                        Text(' ${listaObavjestenja[index].textObavjestenja}'),
                    /*trailing: Text(
                      ' ${listaObavjestenja[index].vrijemeObavjestenja.toString().substring(0, 16)}'),*/
                  ),*/
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 1,
        ),
      ),
    );
  }
}
