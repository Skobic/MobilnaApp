import 'package:flutter/material.dart';

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
          alignment: Alignment.topRight,
          child: IconButton(
            padding: const EdgeInsets.all(5.0),
            color: const Color.fromARGB(255, 137, 178, 211),
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
