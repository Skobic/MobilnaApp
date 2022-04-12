// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:testapp/KorisnikClass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<Korisnik> fetchKorisnik() async {
  final response = await http.get(Uri.parse(
      'http://192.168.0.101:8080/PametnaCitaonicaWeb/api/korisnici/2'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Korisnik.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late Future<Korisnik> futureAlbum;
  @override
  void initState() {
    super.initState();

    futureAlbum = fetchKorisnik();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<Korisnik>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.ime);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
