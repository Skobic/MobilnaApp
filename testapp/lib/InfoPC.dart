// ignore_for_file: file_names, unnecessary_const

import 'package:flutter/material.dart';
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
      backgroundColor: const Color(0xFFD6F4F4),
      appBar: AppBar(title: const Text('O aplikaciji')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10, bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF0961AF),
                        Color(0xFF27AEF7),
                      ],
                    ),
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
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF0961AF),
                        Color(0xFF27AEF7),
                      ],
                    ),
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
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF0961AF),
                                  Color(0xFF27AEF7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: const ListTile(
                            leading: Icon(Icons.insert_emoticon,
                                color: Colors.white, size: 35),
                            title: Text('Stefan Tovilović',
                                textScaleFactor: 1.20,
                                style: TextStyle(color: Colors.white)),
                            subtitle: Text(
                                'Razvoj servera i baze podataka\nstefan.tovilovic@student.etf.unibl.org',
                                textScaleFactor: 1.15,
                                style: TextStyle(color: Colors.white)),
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
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF0961AF),
                                  Color(0xFF27AEF7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: const ListTile(
                            leading: Icon(Icons.insert_emoticon,
                                color: Colors.white, size: 35),
                            title: Text('Luka Divljak',
                                textScaleFactor: 1.15,
                                style: TextStyle(color: Colors.white)),
                            subtitle: Text(
                                'Razvoj servera i baze podataka\nluka.divljak@student.etf.unibl.org',
                                textScaleFactor: 1.15,
                                style: TextStyle(color: Colors.white)),
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
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF0961AF),
                                  Color(0xFF27AEF7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: const ListTile(
                            leading: Icon(Icons.local_florist,
                                color: Colors.white, size: 35),
                            title: Text('Dragana Mišić',
                                textScaleFactor: 1.15,
                                style: TextStyle(color: Colors.white)),
                            subtitle: Text(
                                'Razvoj mobilne i web aplikacije\ndragana.misic@student.etf.unibl.org',
                                textScaleFactor: 1.15,
                                style: TextStyle(color: Colors.white)),
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
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF0961AF),
                                  Color(0xFF27AEF7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: const ListTile(
                            leading: Icon(Icons.insert_emoticon,
                                color: Colors.white, size: 35),
                            title: Text('Nikola Blagojević',
                                textScaleFactor: 1.15,
                                style: TextStyle(color: Colors.white)),
                            subtitle: Text(
                                'Razvoj mobilne i web aplikacije\nnikola.m.blagojevic@student.etf.unibl.org',
                                textScaleFactor: 1.15,
                                style: TextStyle(color: Colors.white)),
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
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF0961AF),
                                  Color(0xFF27AEF7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: const ListTile(
                            leading: Icon(Icons.insert_emoticon,
                                color: Colors.white, size: 35),
                            title: Text('Miloš Škobić',
                                textScaleFactor: 1.15,
                                style: TextStyle(color: Colors.white)),
                            subtitle: Text(
                                'Razvoj mobilne i web aplikacije\nmilos.skobic@student.etf.unibl.org',
                                textScaleFactor: 1.15,
                                style: TextStyle(color: Colors.white)),
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
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF0961AF),
                        Color(0xFF27AEF7),
                      ],
                    ),
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
