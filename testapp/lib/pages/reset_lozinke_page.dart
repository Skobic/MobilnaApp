// ignore_for_file: file_names

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/api/zaboravljena_lozinka_service.dart';
import 'package:testapp/constants/config.dart';
import 'package:testapp/models/requests/reset_lozinke_request.dart';
import 'package:testapp/models/requests/zaboravljena_lozinka_email_request.dart';

//import 'package:flutter_email_sender/flutter_email_sender.dart';
class ResetLozinkePage extends StatefulWidget {
  const ResetLozinkePage({Key? key}) : super(key: key);

  @override
  _ResetLozinkePageState createState() => _ResetLozinkePageState();
}

class _ResetLozinkePageState extends State<ResetLozinkePage> {
  String unosToken = '';
  String unosNovaLozinka = '';
  String unosNovaLozinkaPotvrda = '';
  Dio dioCl = Dio();
  ZaboravljenaLozinkaService zaboravljenaLozinkaService =
      ZaboravljenaLozinkaService();
  ResetLozinkeRequest resetInfo = ResetLozinkeRequest(token: '', lozinka: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: scaffoldBoja,
        title: const Text('Reset lozinke'),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          const SizedBox(height: 10, width: double.infinity),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 5, bottom: 5),
            child: Card(
              child: Container(
                width: 380,
                decoration: BoxDecoration(
                    color: scaffoldBoja,
                    borderRadius: BorderRadius.circular(10)),
                child: const ListTile(
                  leading: Icon(Icons.announcement_outlined,
                      color: Colors.white, size: 55),
                  title: Text(
                      'Da biste povratili lozinku potrebno je da unesete kod koji smo vam poslali na e-mail !',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 10),
            child: SizedBox(
              width: 380,
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),

              child: TextFormField(
                onChanged: (text) {
                  unosToken = text;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: scaffoldBoja),
                    fillColor: Color.fromARGB(218, 226, 226, 226),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Kod',
                    hintText: 'Unesite kod sa e-maila'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 10),
            child: SizedBox(
              width: 380,
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),

              child: TextFormField(
                onChanged: (text) {
                  unosNovaLozinka = text;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: scaffoldBoja),
                    fillColor: Color.fromARGB(218, 226, 226, 226),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Nova lozinka',
                    hintText: 'Unesite novu lozinku'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 10),
            child: SizedBox(
              width: 380,
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),

              child: TextFormField(
                onChanged: (text) {
                  unosNovaLozinkaPotvrda = text;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: scaffoldBoja),
                    fillColor: Color.fromARGB(218, 226, 226, 226),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Potvrda nove lozinke',
                    hintText: 'Ponovo unesite novu lozinku'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 10),
            //Kada se prilikom registracije stisne dugme sacuvaj, prvo se provjerava da li su uneseni podaci u sva polja
            //Nakon toga se provjerava da li je duzina lozinke minimum 8 karakera
            //Nakon toga da li se poklapaju lozinke i ako je sve to ispunjeno onda se uspjesno registruje
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: scaffoldBoja,
                fixedSize: const Size(100, 40),
              ),
              onPressed: () async {
                if (unosToken.isEmpty ||
                    unosNovaLozinka.isEmpty ||
                    unosNovaLozinkaPotvrda.isEmpty) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Neispravan unos'),
                      content: const Text('Morate popuniti sve podatke !'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (unosNovaLozinka.length < 8) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Neispravan unos'),
                      content: const Text(
                          'Nova lozinka mora biti dugačka najmanje 8 karaktera !'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            var nav = Navigator.of(context);
                            //Navigator.pop(context, 'OK');
                            nav.pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (unosNovaLozinka != unosNovaLozinkaPotvrda) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Neispravan unos'),
                      content: const Text('Unesene lozinke se ne poklapaju !'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            var nav = Navigator.of(context);
                            //Navigator.pop(context, 'OK');
                            nav.pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  resetInfo.token = unosToken;
                  resetInfo.lozinka = unosNovaLozinkaPotvrda;

                  try {
                    Response? odgovor = await dioCl.post(
                        'https://10.0.2.2:8443/api/v1/zaboravljena-lozinka-promjena/',
                        data: resetInfo.toJson());

                    if (odgovor.statusCode != null) {
                      if (odgovor.statusCode == 201 ||
                          odgovor.statusCode == 200) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Reset lozinke'),
                            content: const Text(
                                'Uspješno ste resetovali lozinku, sada se možete ponovo prijaviti !'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  var nav = Navigator.of(context);
                                  //Navigator.pop(context, 'OK');
                                  nav.pop();
                                  nav.pop();
                                  nav.pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  } on DioError catch (err) {
                    if (err.response?.statusCode == 403) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Greška'),
                          content: const Text('Kod nije ispravan !'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                var nav = Navigator.of(context);
                                //Navigator.pop(context, 'OK');
                                nav.pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Greška'),
                          content: const Text('Greška na serveru !'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                var nav = Navigator.of(context);
                                //Navigator.pop(context, 'OK');
                                nav.pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                }
              },
              child: const Text(
                'Pošalji',
                textScaleFactor: 1.5,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
