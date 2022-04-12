// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:testapp/Profil.dart';
import 'package:testapp/Rezervacije.dart';
import 'package:testapp/wrappers/citaonica_page_wrapper.dart';
import 'package:testapp/wrappers/profil_page_wrapper.dart';
import 'package:testapp/wrappers/rezervacija_page_wrapper.dart';

/*class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nikoletina'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RezervacijePrikaz()));
                },
                child: const Text(
                  'Rezervacije',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Profil()));
                },
                child: const Text(
                  'Profil',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

class PocetnaStrana extends StatefulWidget {
  const PocetnaStrana({Key? key}) : super(key: key);

  @override
  _PocetnaStranaState createState() => _PocetnaStranaState();
}

class _PocetnaStranaState extends State<PocetnaStrana> {
  int _selectedItemIndex = 0;

  List<Widget> screens = [
    const CitaonicePageWrapper(),
    const RezervacijePageWrapper(),
    const ProfilPageWrapper(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 149, 168, 183)),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Čitaonice',
                style: TextStyle(
                  color: Color.fromARGB(255, 65, 65, 65),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                )),
            backgroundColor: const Color.fromARGB(255, 180, 201, 216),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 180, 201, 216),
            selectedFontSize: 20,
            selectedIconTheme: const IconThemeData(
              color: Color.fromARGB(255, 65, 65, 65),
              size: 40,
            ),
            unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
            elevation: 30,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Citaonice',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.lock_clock),
                label: 'Rezervacije',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profill',
              ),
            ],
            currentIndex: _selectedItemIndex,
            onTap: _onItemTapped,
          ),
          body: IndexedStack(index: _selectedItemIndex, children: screens)),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }
}
