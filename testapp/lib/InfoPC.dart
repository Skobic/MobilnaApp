// ignore_for_file: file_names, unnecessary_const

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/constants/config.dart';
import 'PrijaviBag.dart';

class InformacijePC extends StatefulWidget {
  const InformacijePC({Key? key}) : super(key: key);

  @override
  _InformacijePCState createState() => _InformacijePCState();
}

class _InformacijePCState extends State<InformacijePC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('O aplikaciji',
            style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(
              color: Color.fromARGB(255, 254, 254, 254),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ))),
        backgroundColor: scaffoldBoja,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10, bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: scaffoldBoja,
                    borderRadius: BorderRadius.circular(10)),
                child: const ExpansionTile(
                  collapsedIconColor: Colors.white,
                  leading:
                      Icon(Icons.build_circle, color: Colors.white, size: 35),
                  title: Text('Razvoj',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                        child: Text(
                            'Pametna čitaonica je nastala početkom 2022. godine na Elektrotehničkom fakultetu u Banjoj Luci kao studentski projekat pod nadzorom profesora Dražena Brđanina.\nNamjenjena je svim ljudima koji koriste čitaonice i žele unaprijed rezervisati mjesta u njima, kao i pratiti stanje zauzetosti mjesta u realnom vremenu.',
                            style: TextStyle(color: Colors.white),
                            textScaleFactor: 1.25))
                  ],
                ),
              ),
            ),
            /*onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PromjenaLozinke()));
                  },*/

            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: scaffoldBoja,
                    borderRadius: BorderRadius.circular(10)),
                child: ExpansionTile(
                  collapsedIconColor: Colors.white,
                  leading: const Icon(Icons.account_circle,
                      color: Colors.white, size: 35),
                  title: const Text('Razvojni tim',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, top: 2, bottom: 2),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const ListTile(
                            leading: Icon(Icons.insert_emoticon,
                                color: scaffoldBoja, size: 35),
                            title: Text('Stefan Tovilović',
                                textScaleFactor: 1.20,
                                style: TextStyle(color: scaffoldBoja)),
                            subtitle: Text(
                                'Razvoj servera i baze podataka\nstefan.tovilovic@student.etf.unibl.org',
                                textScaleFactor: 1.15,
                                style: TextStyle(
                                  color: scaffoldBoja,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, top: 2, bottom: 2),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const ListTile(
                            leading: Icon(Icons.insert_emoticon,
                                color: scaffoldBoja, size: 35),
                            title: Text('Luka Divljak',
                                textScaleFactor: 1.15,
                                style: TextStyle(
                                  color: scaffoldBoja,
                                )),
                            subtitle: Text(
                                'Razvoj servera i baze podataka\nluka.divljak@student.etf.unibl.org',
                                textScaleFactor: 1.15,
                                style: TextStyle(
                                  color: scaffoldBoja,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, top: 2, bottom: 2),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const ListTile(
                            leading: Icon(Icons.local_florist,
                                color: scaffoldBoja, size: 35),
                            title: Text('Dragana Mišić',
                                textScaleFactor: 1.15,
                                style: TextStyle(
                                  color: scaffoldBoja,
                                )),
                            subtitle: Text(
                                'Razvoj mobilne i web aplikacije\ndragana.misic@student.etf.unibl.org',
                                textScaleFactor: 1.15,
                                style: TextStyle(
                                  color: scaffoldBoja,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, top: 2, bottom: 2),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const ListTile(
                            leading: Icon(Icons.insert_emoticon,
                                color: scaffoldBoja, size: 35),
                            title: Text('Nikola Blagojević',
                                textScaleFactor: 1.15,
                                style: TextStyle(
                                  color: scaffoldBoja,
                                )),
                            subtitle: Text(
                                'Razvoj mobilne i web aplikacije\nnikola.m.blagojevic@student.etf.unibl.org',
                                textScaleFactor: 1.15,
                                style: TextStyle(
                                  color: scaffoldBoja,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, top: 2, bottom: 2),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const ListTile(
                            leading: Icon(Icons.insert_emoticon,
                                color: scaffoldBoja, size: 35),
                            title: Text('Miloš Škobić',
                                textScaleFactor: 1.15,
                                style: TextStyle(
                                  color: scaffoldBoja,
                                )),
                            subtitle: Text(
                                'Razvoj mobilne i web aplikacije\nmilos.skobic@student.etf.unibl.org',
                                textScaleFactor: 1.15,
                                style: TextStyle(
                                  color: scaffoldBoja,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                /*onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PromjenaLozinke()));
                  },*/
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 5, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: scaffoldBoja,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: const Icon(Icons.report_problem,
                      color: Colors.white, size: 35),
                  title: const Text('Prijavi grešku na aplikaciji',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const PrijaviBag()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
