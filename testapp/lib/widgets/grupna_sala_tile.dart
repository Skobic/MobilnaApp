import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/responses/grupna_sala_response.dart';
import '../pages/grupna_sala_dialog.dart';

class GrupnaSalaTile extends StatelessWidget {
  final GrupnaSalaResponse grupnaSalaData;
  const GrupnaSalaTile({Key? key, required this.grupnaSalaData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      elevation: 4,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        tileColor: const Color.fromARGB(255, 245, 245, 245),
        onTap: () => showCustomDialog(context),
        title: Text(grupnaSalaData.naziv,
            style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 86, 86, 86),
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(grupnaSalaData.brojMjesta.toString(),
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

  void showCustomDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return GrupnaSalaDialog(
          grupnaSalaData: grupnaSalaData,
        );
      });
}
