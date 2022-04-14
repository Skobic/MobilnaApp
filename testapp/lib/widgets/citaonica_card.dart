import 'package:flutter/material.dart';
import 'package:testapp/constants/config.dart';
import 'package:testapp/pocetna_strana.dart';

import '../models/responses/citaonica_response.dart';

class CitaonicaCard extends StatelessWidget {
  final CitaonicaResponse citaonicaData;
  const CitaonicaCard({Key? key, required this.citaonicaData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.87,
          height: MediaQuery.of(context).size.height * 0.26,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(18),
              color: const Color.fromARGB(255, 255, 255, 255)),
          child: Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                navigatorKey.currentState!
                    .pushNamed('pregled_citaonice', arguments: citaonicaData);
              },
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text(citaonicaData.name,
                            style: const TextStyle(
                                color: podnaslovBoja,
                                fontSize: 25,
                                fontWeight: FontWeight.bold))),
                  ),
                  Expanded(
                    child: Container(
                      //height: (MediaQuery.of(context).size.height * 0.26) * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                                'http://10.0.2.2:8080/api/v1/citaonice/${citaonicaData.id}/slika'),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
