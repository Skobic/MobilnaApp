// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrisanjeNaloga extends StatefulWidget {
  const BrisanjeNaloga({Key? key}) : super(key: key);

  @override
  _BrisanjeNalogaState createState() => _BrisanjeNalogaState();
}

class _BrisanjeNalogaState extends State<BrisanjeNaloga> {
  String unosLozinka = '', unosLozinkaPotvrda = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Brisanje naloga'),
          backgroundColor: Colors.blue[700]),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD6F4F4),
              Color(0xFFD6F4F4),
            ],
          ),
        ),
        child: ListView(
          //child: Column(
          children: <Widget>[
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 10),
              child: TextFormField(
                obscureText: true,
                onChanged: (text) {
                  unosLozinka = text;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password, color: Colors.blue[700]),
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Lozinka',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Unesite vašu lozinku'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 10),
              child: TextFormField(
                obscureText: true,
                onChanged: (text) {
                  unosLozinkaPotvrda = text;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password, color: Colors.blue[700]),
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Potvrda lozinke',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Ponovo unesite vašu lozinku'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 10),

              //Kada se prilikom registracije stisne dugme sacuvaj, prvo se provjerava da li su uneseni podaci u sva polja
              //Nakon toga se provjerava da li je duzina lozinke minimum 8 karakera
              //Nakon toga da li se poklapaju lozinke i ako je sve to ispunjeno onda se uspjesno registruje
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue[700]),
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  final String? trenutnaLozinka =
                      preferences.getString('lozinka');
                  if (unosLozinka.isEmpty || unosLozinkaPotvrda.isEmpty) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Neispravan unos'),
                        content: const Text('Morate popuniti sve podatke'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else if (unosLozinka != trenutnaLozinka) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Neispravna lozinka'),
                        content: const Text('Unijeli ste netačnu lozinku !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else if (unosLozinka != unosLozinkaPotvrda) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Neispravna potvrda'),
                        content:
                            const Text('Unesene lozinke se ne poklapaju !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Brisanje naloga'),
                        content: const Text(
                            'Da li ste sigurni da želite obrisati nalog ?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Brisanje naloga'),
                                  content:
                                      const Text('Uspješno ste obrisali nalog'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.remove('email');
                                        final pref = await SharedPreferences
                                            .getInstance();
                                        await pref.clear();
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            "/LoginPage",
                                            (r) => false);
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
                },
                child: const Text(
                  'Obriši nalog',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
