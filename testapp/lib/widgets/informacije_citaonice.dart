import 'package:flutter/material.dart';

import '../constants/config.dart';

class InformacijeCitaonice extends StatelessWidget {
  const InformacijeCitaonice({Key? key}) : super(key: key);

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
              text: const TextSpan(
                style: TextStyle(fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Adresa: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 63, 63, 63))),
                  TextSpan(
                      text: 'Srpskijeh rudara',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 63, 63, 63))),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Telefon: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 63, 63, 63))),
                  TextSpan(
                      text: '065/234-237',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 63, 63, 63))),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: 'E-mail: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 63, 63, 63))),
                  TextSpan(
                      text: 'etf@unibl.com',
                      style: TextStyle(
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
