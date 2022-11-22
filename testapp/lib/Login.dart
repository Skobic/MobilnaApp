// ignore_for_file: deprecated_member_use, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/ZaboravljenaLozinka.dart';
import 'package:testapp/models/requests/registracija_request.dart';
import 'api/dio_client.dart';
import 'pocetna_strana.dart';
import 'Registracija.dart';
import 'ZaboravljenaLozinka.dart';

int idKorisnika = -1;
String lozinkaKorisnika = '';

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  //late Future<Korisnik> test;
  DioClient dioCL = DioClient();

  final korisnickoImeController = TextEditingController(text: '');
  final lozinkaController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    double visina = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: visina,
          child: Container(
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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 60.0,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 280,
                      height: 180,
                      /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                      child: Image.asset('assets/images/pametni_skoba.png',
                          scale: 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 5, bottom: 15),
                  child: SizedBox(
                    width: 320,
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),

                    child: TextFormField(
                      controller: korisnickoImeController,
                      decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.email, color: Colors.blue[700]),
                          fillColor: const Color(0xAAFFFFFF),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Korisničko ime',
                          hintText: 'Unesite korisničko ime'),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 0, bottom: 15),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: 320,
                    child: TextFormField(
                      controller: lozinkaController,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.blue[700]),
                          fillColor: const Color(0xAAFFFFFF),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Lozinka',
                          hintText: 'Unesite lozinku'),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 320,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF0961AF),
                          Color(0xFF27AEF7),
                          //Color(0xAAFFFFFF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () async {
                      if (korisnickoImeController.text.isEmpty ||
                          lozinkaController.text.length < 3) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Neispravan unos'),
                                  content: const Text(
                                      'Unijeli ste neispravan email ili lozinku !'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      } else {
                        Response odgovor = await dioCL.dio.post(
                            'https://10.0.2.2:8443/api/v1/prijava/',
                            data: {
                              "korisnickoIme": korisnickoImeController.text,
                              "lozinka": lozinkaController.text
                            });
                        if (odgovor.statusCode == 201 &&
                            odgovor.data['uloga'] == 'KORISNIK') {
                          idKorisnika = odgovor.data['id'];
                          lozinkaKorisnika = lozinkaController.text;

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                              'accessToken', odgovor.data['accessToken']);
                          prefs.setString(
                              'refreshToken', odgovor.data['refreshToken']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const PocetnaStrana()));
                        }
                      }
                    },
                    child: const Text(
                      'Prijavi se',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ZaboravljenaLozinka()));
                  },
                  child: Text(
                    'Zaboravili ste lozinku?',
                    style: TextStyle(color: Colors.blue[800], fontSize: 15),
                  ),
                ),

                const Spacer(),
                Text(
                  'Nemate nalog?',
                  style: TextStyle(color: Colors.grey[700], fontSize: 15),
                ),
                //const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    //height: 25,
                    // width: 200,

                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Registracija()));
                      },
                      child: Text(
                        'Registruj se',
                        style: TextStyle(color: Colors.blue[800], fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
