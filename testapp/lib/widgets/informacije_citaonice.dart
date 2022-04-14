import 'package:flutter/material.dart';
import 'package:testapp/models/responses/citaonica_response.dart';

import '../constants/config.dart';

class InformacijeCitaonice extends StatelessWidget {
  final CitaonicaResponse citaonicaData;
  const InformacijeCitaonice({Key? key, required this.citaonicaData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Naziv',
            //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 18),
                children: <TextSpan>[
                  const TextSpan(
                      text: 'Adresa: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 63, 63, 63))),
                  TextSpan(
                      text: citaonicaData.adresa,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 63, 63, 63))),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 18),
                children: <TextSpan>[
                  const TextSpan(
                      text: 'Telefon: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 63, 63, 63))),
                  TextSpan(
                      text: citaonicaData.phoneNumber,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 63, 63, 63))),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  const TextSpan(
                      text: 'E-mail: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 63, 63, 63))),
                  TextSpan(
                      text: citaonicaData.mail,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 63, 63, 63))),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
        Align(
          child: IconButton(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(3.0),
            color: podnaslovBoja,
            splashRadius: 27,
            iconSize: 45,
            icon: const Icon(Icons.circle_notifications_outlined),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
