import 'package:flutter/material.dart';
import 'package:testapp/pocetna_strana.dart';

import '../pages/pregled_citaonice_page.dart';

class CitaonicaCard extends StatelessWidget {
  const CitaonicaCard({Key? key}) : super(key: key);

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
              color: const Color.fromARGB(255, 255, 253, 253)),
          child: Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                navigatorKey.currentState!.pushNamed('pregled_citaonice');
              },
              child: Column(
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height * 0.26) * 0.6,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                      image: DecorationImage(
                          image: AssetImage('assets/images/etf.png'),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.all(9.0),
                        child: Text('Citaonica',
                            style: TextStyle(
                                color: Color.fromARGB(255, 137, 178, 211),
                                fontSize: 25,
                                fontWeight: FontWeight.bold))),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
