// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//String name = 'Pametne citaonica';
//email = 'milosskobic@hotmail.com',
//message = 'lozinka123',
// pcEmail = 'pametna.citaonica@gmail.com';

Future sendEmail(String message, String pcEmail, String trenutniEmail) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = 'service_74bipio';
  const templateId = 'template_dxmf40u';
  const userId = 'user_SxEjOEBkJj7LixafHfkff';
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
          'to_email': pcEmail,
          'name': trenutniEmail,
          'message': message
        }
      }));
  return response.statusCode;
}

//import 'package:flutter_email_sender/flutter_email_sender.dart';
class PrijaviBag extends StatefulWidget {
  const PrijaviBag({Key? key}) : super(key: key);

  @override
  _PrijaviBagState createState() => _PrijaviBagState();
}

class _PrijaviBagState extends State<PrijaviBag> {
  String unosMessage = '', pcEmail = 'pametna.citaonica@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6F4F4),
      appBar: AppBar(
        title: const Text('Prijavi grešku'),
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
                        'Ako ste uočili gresku na aplikaciji molimo vas da je ispod što detaljnije opišete kako bi je mogli što prije otkloniti !',
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
                    unosMessage = text;
                  },
                  maxLines: 12,
                  decoration: const InputDecoration(
                      // prefixIcon: Icon(Icons.email, color: Color(0xFF27AEF7)),
                      fillColor: Color(0xAAFFFFFF),
                      filled: true,
                      border: OutlineInputBorder(),
                      //labelText: 'Opis greške',
                      hintText: 'Opiši grešku'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF27AEF7),
                  fixedSize: const Size(100, 40),
                ),
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  final String? trenutniEmail = preferences.getString('email');
                  final response =
                      await sendEmail(unosMessage, pcEmail, trenutniEmail!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    response == 200
                        ? const SnackBar(
                            content: Text('Vaša prijava je poslata, hvala !'),
                            backgroundColor: Colors.green)
                        : const SnackBar(
                            content: Text('Neuspješno slanje !'),
                            backgroundColor: Colors.red),
                  );
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
