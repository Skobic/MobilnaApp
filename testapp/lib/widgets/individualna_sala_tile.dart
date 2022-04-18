import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/models/responses/individualna_sala_response.dart';

import '../pocetna_strana.dart';

class IndividualnaSalaTile extends StatelessWidget {
  final IndividualnaSalaResponse individualnaSalaData;
  const IndividualnaSalaTile({Key? key, required this.individualnaSalaData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        tileColor: const Color.fromARGB(255, 245, 245, 245),
        onTap: () {
          navigatorKey.currentState!.pushNamed('pregled_individualne_sale',
              arguments: individualnaSalaData);
        },
        title: Text(
          individualnaSalaData.naziv,
          style: GoogleFonts.ubuntu(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 86, 86, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(individualnaSalaData.brojMjesta.toString(),
              style: const TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 116, 116, 116))),
          const SizedBox(width: 5),
          const Icon(
            Icons.person,
            size: 17,
            color: Color.fromARGB(255, 116, 116, 116),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 86, 86, 86))
        ]),
      ),
    );
  }
}
