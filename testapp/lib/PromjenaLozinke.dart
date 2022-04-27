// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Login.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/api/promjena_lozinke_service.dart';
import 'package:testapp/constants/config.dart';
import 'package:testapp/models/requests/promjena_lozinke_request.dart';

class PromjenaLozinke extends StatefulWidget {
  const PromjenaLozinke({Key? key}) : super(key: key);

  @override
  _PromjenaLozinkeState createState() => _PromjenaLozinkeState();
}

class _PromjenaLozinkeState extends State<PromjenaLozinke> {
  String unosLozinka = '', novaLozinka = '', novaLozinkaPotvrda = '';
  DioClient dioCl = DioClient();
  PromjenaLozinkeService promjenaLozinkeService = PromjenaLozinkeService();
  PromjenaLozinkeRequest promjenaLozinkeInfo =
      PromjenaLozinkeRequest(staraLozinka: '', novaLozinka: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldBoja,
        title: Text('Promjena lozinke',
            style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(
              color: Color.fromARGB(255, 254, 254, 254),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ))),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView(
          // child: Column(
          children: <Widget>[
            /* Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 10),
              child: TextFormField(
                onChanged: (text) {
                  unosEmail = text;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.blue[700]),
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'E-mail',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Unesite vašu email adresu'),
              ),
            ),*/
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
                    prefixIcon: Icon(Icons.lock, color: scaffoldBoja),
                    fillColor: Color.fromARGB(218, 226, 226, 226),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Trenutna lozinka',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Unesite vašu trenutnu lozinku'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 10),
              child: TextFormField(
                obscureText: true,
                onChanged: (text) {
                  novaLozinka = text;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    prefixIcon: Icon(Icons.password, color: scaffoldBoja),
                    fillColor: Color.fromARGB(218, 226, 226, 226),
                    filled: true,
                    labelText: 'Nova lozinka',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Unesite vašu novu loznku'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 10),
              child: TextFormField(
                obscureText: true,
                onChanged: (text) {
                  novaLozinkaPotvrda = text;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password, color: scaffoldBoja),
                    fillColor: Color.fromARGB(218, 226, 226, 226),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Potvrda nove lozinka',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Ponovo unesite vašu novu loznku'),
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
                  // style: ElevatedButton.styleFrom(primary: scaffoldBoja),
                  onPressed: () async {
                    if (unosLozinka.isEmpty ||
                        novaLozinka.isEmpty ||
                        novaLozinkaPotvrda.isEmpty) {
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
                    }
                    /* else if (trenutnaLozinka != unosLozinka) {
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
                    }*/
                    else if (novaLozinka.length < 8) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Neispravna nova lozinka'),
                          content: const Text(
                              'Dužina nove lozinke mora biti 8 ili vise karaktera !'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else if (novaLozinka == unosLozinka) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Neispravna nova lozinka'),
                          content: const Text(
                              'Nova lozinka ne može biti ista kao ona koju ste unijeli u polje za trenutnu lozinku !'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else if (novaLozinka != novaLozinkaPotvrda) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Neispravne lozinke'),
                          content: const Text('Nove lozinke se ne poklapaju !'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      promjenaLozinkeInfo.staraLozinka = unosLozinka;
                      promjenaLozinkeInfo.novaLozinka = novaLozinkaPotvrda;
                      promjeniLozinku();
                    }
                  },
                  child: const Text(
                    'Sačuvaj',
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 1.8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void promjeniLozinku() async {
    var response = await promjenaLozinkeService.promjeniLozinku(
        dioClient: dioCl, promjenaLozinkeData: promjenaLozinkeInfo);
    if (response?.statusCode == 201 || response?.statusCode == 200) {
      lozinkaKorisnika = novaLozinkaPotvrda;
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Uspješna promjena lozinke'),
          content: const Text('Čestitamo, uspješno ste promjenili lozinku !'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/LoginPage", (r) => false);
                // nav.pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (response?.statusCode == 403) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Greška'),
          content: const Text('Trenutna lozinka nije ispravna !'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                var nav = Navigator.of(context);
                //Navigator.pop(context, 'OK');
                nav.pop();
                //nav.pop();
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
