// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/constants/config.dart';
import 'package:testapp/pages/pregled_citaonice_page.dart';
import 'package:testapp/pages/pregled_individualne_sale.dart';
import 'package:testapp/wrappers/citaonica_page_wrapper.dart';
import 'package:testapp/wrappers/profil_page_wrapper.dart';
import 'package:testapp/wrappers/rezervacija_page_wrapper.dart';

import 'models/responses/citaonica_response.dart';
import 'models/responses/individualna_sala_response.dart';

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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _PocetnaStranaState extends State<PocetnaStrana> {
  int _selectedItemIndex = 0;
  String naslov = 'Čitaonice';
  List<String> sviNaslovi = <String>['Čitaonice', 'Rezervacije', 'Profil'];
  List<Widget> screens = [
    const CitaonicePageWrapper(),
    const RezervacijePageWrapper(),
    const ProfilPageWrapper(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 149, 168, 183)),
        home: Scaffold(
            appBar: AppBar(
              title: Text(naslov,
                  style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(
                    color: Color.fromARGB(255, 254, 254, 254),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ))),
              backgroundColor: scaffoldBoja,
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: scaffoldBoja,
              selectedFontSize: 20,
              selectedIconTheme: const IconThemeData(
                color: Color.fromARGB(255, 67, 84, 64),
                size: 35,
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
        onGenerateRoute: (settings) {
          WidgetBuilder builder;

          switch (settings.name) {
            case 'pregled_citaonice':
              builder = (BuildContext context) => PregledCitaonicePage(
                  citaonicaData: settings.arguments as CitaonicaResponse);
              break;
            case 'pregled_individualne_sale':
              builder = (BuildContext context) => IndSalaView(
                  individualnaSalaData:
                      settings.arguments as IndividualnaSalaResponse);
              break;
            default:
              throw Exception('Invalid route:}');
          }
          return MaterialPageRoute<void>(
              builder: builder, settings: settings, maintainState: false);
        }
        // routes: {
        //   "pregled_citaonice": (BuildContext context) => PregledCitaonicePage(),
        //   "pregled_individualne_sale": (BuildContext context) =>
        //       const IndSalaView('ime')
        // },
        );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedItemIndex = index;
      naslov = sviNaslovi[index];
    });
  }
}
