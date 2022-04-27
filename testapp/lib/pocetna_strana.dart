// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/BrisanjeNaloga.dart';
import 'package:testapp/InfoPC.dart';
import 'package:testapp/PromjenaLozinke.dart';
import 'package:testapp/Uputstvo.dart';
import 'package:testapp/constants/config.dart';
import 'package:testapp/models/other/argumenti_grupne_potvrd_dolaska.dart';
import 'package:testapp/models/other/argumenti_individualne_potvrde_dolaska.dart';
import 'package:testapp/models/requests/potvrda_dolaska_request.dart';
import 'package:testapp/pages/grupna_potvrda_dolaska.dart';
import 'package:testapp/pages/individualna_potvrda_dolaska.dart';
import 'package:testapp/pages/pregled_citaonice_page.dart';
import 'package:testapp/pages/pregled_individualne_sale.dart';
import 'package:testapp/wrappers/citaonica_page_wrapper.dart';
import 'package:testapp/wrappers/profil_page_wrapper.dart';
import 'package:testapp/wrappers/rezervacija_page_wrapper.dart';

import 'models/responses/citaonica_response.dart';
import 'models/responses/individualna_sala_response.dart';

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
        home: Scaffold(
            backgroundColor: Colors.white,
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
            case 'individualna_potvrda_dolaska':
              builder = (BuildContext context) => IndividualnaPotvrdaDolaska(
                    argInfo: settings.arguments
                        as ArgumentiIndividualnePotvrdeDolaska,
                  );
              break;
            case 'grupna_potvrda_dolaska':
              builder = (BuildContext context) => GrupnaPotvrdaDolaska(
                    argInfo:
                        settings.arguments as ArgumentiGrupnePotvrdeDolaska,
                  );
              break;
            case 'promjena_lozinke':
              builder = (BuildContext context) => const PromjenaLozinke();
              break;
            case 'uputstvo_za_koristenje':
              builder = (BuildContext context) => const UputstvoPC();
              break;
            case 'o_aplikaciji':
              builder = (BuildContext context) => const InformacijePC();
              break;
            case 'brisanje_naloga':
              builder = (BuildContext context) => const BrisanjeNaloga();
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
