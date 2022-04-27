// ignore_for_file: file_names

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/api/zaboravljena_lozinka_service.dart';
import 'package:testapp/constants/config.dart';
import 'package:testapp/models/requests/zaboravljena_lozinka_email_request.dart';
import 'package:testapp/pages/reset_lozinke_page.dart';
import 'Login.dart';

String name = 'Pametne citaonica',
    message = 'lozinka123',
    pcEmail = 'pametna.citaonica@gmail.com';

//import 'package:flutter_email_sender/flutter_email_sender.dart';
class ZaboravljenaLozinka extends StatefulWidget {
  const ZaboravljenaLozinka({Key? key}) : super(key: key);

  @override
  _ZaboravljenaLozinkaState createState() => _ZaboravljenaLozinkaState();
}

class _ZaboravljenaLozinkaState extends State<ZaboravljenaLozinka> {
  String unosEmail = '';
  DioClient dioCl = DioClient();
  ZaboravljenaLozinkaService zaboravljenaLozinkaService =
      ZaboravljenaLozinkaService();
  ZaboravljenaLozinkaEmailRequest emailInfo =
      ZaboravljenaLozinkaEmailRequest(email: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: scaffoldBoja,
        title: const Text('Zaboravljena lozinka'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                        'Da biste povratili lozinku potrebno je da unesete email koji ste koristili prilikom kreiranja naloga !',
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
                    unosEmail = text;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: scaffoldBoja),
                      fillColor: Color.fromARGB(218, 226, 226, 226),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'E-mail',
                      hintText: 'Unesite vasu email adresu'),
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
                  if (!isEmail(unosEmail)) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Neispravan unos'),
                        content: const Text('Morate unijeti ispravan email !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    emailInfo.email = unosEmail;
                    var odgovor = await zaboravljenaLozinkaService.slanjeEmaila(
                        dioClient: dioCl, emailData: emailInfo);
                    if (odgovor?.statusCode == 200 ||
                        odgovor?.statusCode == 201) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ResetLozinkePage()));
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

                    /*final response = await sendEmail(name, unosEmail, message);
                    ScaffoldMessenger.of(context).showSnackBar(
                      response == 200
                          ? const SnackBar(
                              content: Text(
                                  'Poruka poslata, provjerite vas email !'),
                              backgroundColor: Colors.green)
                          : const SnackBar(
                              content: Text('Neuspjesno slanje !'),
                              backgroundColor: Colors.red),
                    );*/
                    /*showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Uspjesno slanje'),
                    content:
                        const Text('Provjerite unijetu email adresu !'),
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
                );*/
                  }
                },
                child: const Text(
                  'Pošalji',
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
