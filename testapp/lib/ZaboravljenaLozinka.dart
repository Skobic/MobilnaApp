// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'Login.dart';

String name = 'Pametne citaonica',
    message = 'lozinka123',
    pcEmail = 'pametna.citaonica@gmail.com';

Future sendEmail(String name, String email, String message) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = 'service_5pusse4';
  const templateId = 'template_6e6rzuv';
  const userId = 'user_CbPgIqRxGl83V7W9dwrvA';
  final response = await http.post(url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json'
      }, //This line makes sure it works for all platforms.
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'to_email': email,
          'from_name': name,
          //'from_email': pcEmail,
          'message': message
        }
      }));
  return response.statusCode;
}

//import 'package:flutter_email_sender/flutter_email_sender.dart';
class ZaboravljenaLozinka extends StatefulWidget {
  const ZaboravljenaLozinka({Key? key}) : super(key: key);

  @override
  _ZaboravljenaLozinkaState createState() => _ZaboravljenaLozinkaState();
}

class _ZaboravljenaLozinkaState extends State<ZaboravljenaLozinka> {
  String unosEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6F4F4),
      appBar: AppBar(
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
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF27AEF7),
                          Color(0xFF27AEF7),
                        ],
                      ),
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
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Color(0xFF27AEF7)),
                      fillColor: Color(0xAAFFFFFF),
                      filled: true,
                      border: OutlineInputBorder(),
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
                  primary: const Color(0xFF27AEF7),
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
                    final response = await sendEmail(name, unosEmail, message);
                    ScaffoldMessenger.of(context).showSnackBar(
                      response == 200
                          ? const SnackBar(
                              content: Text(
                                  'Poruka poslata, provjerite vas email !'),
                              backgroundColor: Colors.green)
                          : const SnackBar(
                              content: Text('Neuspjesno slanje !'),
                              backgroundColor: Colors.red),
                    );
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
