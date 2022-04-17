// ignore_for_file: file_names

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/api/registracija_service.dart';
import 'Login.dart';
import 'models/requests/registracija_request.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Registracija extends StatefulWidget {
  const Registracija({Key? key}) : super(key: key);

  @override
  _RegistracijaState createState() => _RegistracijaState();
}

class _RegistracijaState extends State<Registracija> {
  DioClient dioCL = DioClient();
  RegistracijaService regService = RegistracijaService();

  StreamSubscription? connection;
  bool isoffline = false;

  @override
  void initState() {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        setState(() {
          isoffline = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  String korisnickoIme = '',
      email = '',
      lozinka = '',
      potvrdaLozinke = '',
      ime = '',
      prezime = '';

  RegistracijaRequest korisnik = RegistracijaRequest(
      ime: '', prezime: '', korisnickoIme: '', lozinka: '', mail: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6F4F4),
      appBar: AppBar(
        title: const Text('Registracija novog korisnika'),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 10),
              child: TextFormField(
                onChanged: (text) {
                  korisnickoIme = text;
                },
                decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.emoji_emotions, color: Colors.blue[700]),
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Korisničko ime',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Unesite korisničko ime'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5, bottom: 10),
              child: TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.blue[700]),
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Unesite email'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5, bottom: 10),
              child: TextFormField(
                onChanged: (text) {
                  ime = text;
                },
                decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.account_circle, color: Colors.blue[700]),
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Ime',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Unesite vaše ime'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5, bottom: 10),
              child: TextFormField(
                onChanged: (text) {
                  prezime = text;
                },
                decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.account_circle, color: Colors.blue[700]),
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Prezime',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Unesite vaše prezime'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5, bottom: 10),
              child: TextField(
                obscureText: true,
                onChanged: (text) {
                  lozinka = text;
                },
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.lock, color: Colors.blue[700]),
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    labelText: 'Lozinka',
                    hintText: 'Unesite lozinku [minimum 8 karaktera]'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5, bottom: 10),
              child: TextField(
                obscureText: true,
                onChanged: (text) {
                  potvrdaLozinke = text;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.blue[700]),
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    labelText: 'Potvrda lozinke',
                    hintText: 'Ponovo unesite lozinku'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue[700]),
                onPressed: () async {
                  if (ime.isEmpty ||
                      email.isEmpty ||
                      lozinka.isEmpty ||
                      potvrdaLozinke.isEmpty ||
                      korisnickoIme.isEmpty ||
                      prezime.isEmpty) {
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
                  } else if (!isEmail(email)) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Neispravan email'),
                        content:
                            const Text('Unijeli ste nevažeću email adresu !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else if (lozinka.length < 8) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Neispravna lozinka'),
                        content: const Text(
                            'Dužina lozinke mora biti minimum 8 karaktera !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else if (lozinka != potvrdaLozinke) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Neispravne lozinke'),
                        content: const Text('Lozinke se ne poklapaju !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    korisnik.korisnickoIme = korisnickoIme;
                    korisnik.ime = ime;
                    korisnik.prezime = prezime;
                    korisnik.mail = email;
                    korisnik.lozinka = lozinka;
                    //var result = await Connectivity().checkConnectivity();

                    Response? res = await registrujKorisnika();
                    if (res != null) {
                      if (res.statusCode == 201) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Uspješna registracija'),
                            content: const Text(
                                'Čestitamo, uspješno ste se registrovali !\nSada se možete prijaviti u aplikaciju !'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
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
                      }
                    } else {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Greška'),
                          content: const Text(
                              'Molimo promjenite korisničko ime !\nProvjerite da li ste povezani na internet !'),
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
                },
                child: const Text(
                  'Sačuvaj',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Response?> registrujKorisnika() async {
    var odgovor = await regService.createKorisnik(
        dioClient: dioCL, korisnikInfo: korisnik);
    return odgovor;
  }
}
