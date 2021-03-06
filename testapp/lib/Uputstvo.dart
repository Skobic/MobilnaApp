// ignore_for_file: file_names

import 'package:flutter/material.dart';

class UputstvoPC extends StatefulWidget {
  const UputstvoPC({Key? key}) : super(key: key);

  @override
  _UputstvoPCState createState() => _UputstvoPCState();
}

class _UputstvoPCState extends State<UputstvoPC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6F4F4),
      appBar: AppBar(
        title: const Text('Uputstvo za korištenje'),
        backgroundColor: Colors.blue[700],
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
                      Icon(Icons.help_rounded, color: Colors.white, size: 35),
                  title: Text('Kako rezervisati pojedinačno mjesto?',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        child: Text(
                            'Da biste rezervisali pojedinačno mjesto potrebno je izabrati željenu čitaonicu, nakon toga neku od dostupnih pojedinačnih sala i onda morate pitati Nikolu kud dalje.',
                            style: TextStyle(color: Colors.white),
                            textScaleFactor: 1.25))
                  ],
                ),
              ),
            ),
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
                      Icon(Icons.help_rounded, color: Colors.white, size: 35),
                  title: Text('Kako rezervisati grupnu salu?',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                        child: Text(
                            'Da biste rezervisali pojedinačno mjesto potrebno je izabrati željenu čitaonicu, nakon toga neku od dostupnih grupnih sala i onda morate takodje pitati Nikolu.',
                            style: TextStyle(color: Colors.white),
                            textScaleFactor: 1.25))
                  ],
                ),
              ),
            ),
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
                      Icon(Icons.help_rounded, color: Colors.white, size: 35),
                  title: Text(
                      'Šta je potvrda dolaska i kako potvrditi dolazak?',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                        child: Text(
                            'Potvrda dolaska je mehanizam koji aplikacija koristi kako bi znala da su ljudi stvarno došli na vrijeme za svoju rezervaciju.\nNakon što ste rezervisali mjesto potrebno je da dodjete do njega najkasnije 15 minuta nakon početka rezervacije, udjete u meni za rezervacije (srednje dugme na dnu ekrana) i izaberete opciju za potvrdu dolaska ispod željene rezervacije.\nNakon toga skenirajte QR kod koji se nalazi na vašem mjestu i prepustite se učenju. Ukoliko ne potvrdite dolazak do najkasnije 15 minuta nakon početka rezervacije, vaša rezervacija će automatski biti obrisana i dužni ste napustiti to mjesto.',
                            style: TextStyle(color: Colors.white),
                            textScaleFactor: 1.25))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10, bottom: 10),
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
                      Icon(Icons.help_rounded, color: Colors.white, size: 35),
                  title: Text('Kako otkazati rezervaciju?',
                      textScaleFactor: 1.15,
                      style: TextStyle(color: Colors.white)),
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        child: Text(
                            'Rezervacije se otkazuje tako što ćete prvo izabrati meni sa listom vaših rezervacija (srednje dugme na dnu ekrana) i onda izabrati opciju za otkazivanje željene rezervacije. Nakon toga još je potrebno i da potvrdite vasu odluku i rezervacija će biti otkazana.',
                            style: TextStyle(color: Colors.white),
                            textScaleFactor: 1.25))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
