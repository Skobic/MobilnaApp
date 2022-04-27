// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Login.dart';
import 'package:testapp/api/brisanje_naloga_service.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/api/odjava_service.dart';
import 'package:testapp/constants/config.dart';
import 'package:testapp/models/responses/brisanje_naloga_response.dart';

import 'api/dio_client.dart';

class BrisanjeNaloga extends StatefulWidget {
  const BrisanjeNaloga({Key? key}) : super(key: key);

  @override
  _BrisanjeNalogaState createState() => _BrisanjeNalogaState();
}

class _BrisanjeNalogaState extends State<BrisanjeNaloga> {
  String unosLozinka = '', unosLozinkaPotvrda = '';

  DioClient dioCl = DioClient();
  BrisanjeNalogaService brisanjeService = BrisanjeNalogaService();
  BrisanjeNalogaResponse lozinkaData = BrisanjeNalogaResponse(lozinka: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Brisanje naloga',
              style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                color: Color.fromARGB(255, 254, 254, 254),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ))),
          backgroundColor: scaffoldBoja),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
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
                    prefixIcon: Icon(Icons.password, color: scaffoldBoja),
                    fillColor: Color.fromARGB(218, 226, 226, 226),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
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
                    prefixIcon: Icon(Icons.password, color: scaffoldBoja),
                    fillColor: Color.fromARGB(218, 226, 226, 226),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
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
              child: Container(
                decoration: BoxDecoration(
                    color: scaffoldBoja,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  //style: ElevatedButton.styleFrom(primary: scaffoldBoja),
                  onPressed: () async {
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
                    } else if (unosLozinka != lozinkaKorisnika) {
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
                                lozinkaData.lozinka = unosLozinkaPotvrda;
                                obrisiNalog();
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
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void obrisiNalog() async {
    var response = await brisanjeService.obrisiNalog(
        dioClient: dioCl,
        korisnikId: idKorisnika,
        korisnikLozinka: lozinkaData);
    if (response?.statusCode == 204) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Brisanje naloga'),
          content: const Text('Uspješno ste obrisali nalog'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                final pref = await SharedPreferences.getInstance();
                await pref.clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/LoginPage", (r) => false);
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
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
