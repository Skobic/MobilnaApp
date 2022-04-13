import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/constants/config.dart';
import 'package:testapp/widgets/individualna_sala_tile.dart';
import 'package:testapp/widgets/informacije_citaonice.dart';

import '../widgets/grupna_sala_tile.dart';

class PregledCitaonicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PregledCitaonicePageState();
  }
}

class _PregledCitaonicePageState extends State<PregledCitaonicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Naziv',
          style: GoogleFonts.ubuntu(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 254, 254, 254),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: scaffoldBoja,
      ),
      bottomNavigationBar: null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: InformacijeCitaonice(),
            ),
            const Divider(
              height: 25,
              thickness: 2.7,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Individualne sale',
                style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: podnaslovBoja,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                  return IndividualnaSalaTile();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 4);
                },
                itemCount: 3),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Grupne sale',
                style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: podnaslovBoja,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                  return GrupnaSalaTile();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 4);
                },
                itemCount: 3),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
