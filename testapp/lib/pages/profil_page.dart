import 'package:flutter/material.dart';
import 'package:testapp/PromjenaLozinke.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/api/odjava_service.dart';
import '../BrisanjeNaloga.dart';
import '../InfoPC.dart';
import '../Uputstvo.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilPageState();
  }
}

Color pozadina = const Color(0xFF78AECB);
Color pozadina2 = const Color(0xFF78AECB);

DioClient dioCL = DioClient();
OdjavaService odjavaService = OdjavaService();

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFD6F4F4),
            Color(0xFFD6F4F4),
          ],
        ),
      ),
      child: ListView(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 3),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        pozadina,
                        pozadina2,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.account_circle,
                    color: Colors.white, size: 80),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [pozadina, pozadina2],
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: const Icon(Icons.password_sharp,
                      color: Colors.white, size: 35),
                  title: const Text('Promjena lozinke',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PromjenaLozinke()));
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        pozadina,
                        pozadina2,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading:
                      const Icon(Icons.book, color: Colors.white, size: 35),
                  title: const Text('Uputstvo za korištenje',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const UputstvoPC()));
                  },
                ),
              ),
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        pozadina,
                        pozadina2,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: const Icon(Icons.notifications,
                      color: Colors.white, size: 35),
                  title: const Text('Obavještenja',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const Obavjestenja()));
                  },
                ),
              ),
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        pozadina,
                        pozadina2,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading:
                      const Icon(Icons.info, color: Colors.white, size: 35),
                  title: const Text('O aplikaciji',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const InformacijePC()));
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        pozadina,
                        pozadina2,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading:
                      const Icon(Icons.delete, color: Colors.white, size: 35),
                  title: const Text('Brisanje naloga',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BrisanjeNaloga()));
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        pozadina,
                        pozadina2,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading:
                      const Icon(Icons.logout, color: Colors.white, size: 35),
                  title: const Text('Odjava',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Odjava'),
                        content: const Text(
                            'Da li ste sigurni da se želite odjaviti?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              odjaviSe();
                            },
                            child: const Text('Da'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Ne'),
                            child: const Text('Ne'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void odjaviSe() async {
    var response = await odjavaService.createOdjava(dioClient: dioCL);

    if (response?.statusCode == 200 || response?.statusCode == 201) {
      showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Odjava'),
          content: const Text('Uspješno ste se odjavili !'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/LoginPage", (r) => false);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Greška'),
          content: const Text('Greška na serveru !'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
