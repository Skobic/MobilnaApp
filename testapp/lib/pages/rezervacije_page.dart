import 'package:flutter/material.dart';
import 'package:testapp/Login.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/api/individualne_rezervacije_korisnika_service.dart';
import 'package:testapp/constants/config.dart';
import 'package:testapp/models/responses/individualne_rezervacije_korisnika_response.dart';
import 'package:testapp/pages/grupne_rezervacije_page.dart';
import 'package:testapp/pages/individualne_rezervacije_page.dart';
import 'package:testapp/widgets/individualna_rezervacija_card.dart';

class RezervacijePage extends StatefulWidget {
  const RezervacijePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RezervacijePageState();
  }
}

IndividualneRezervacijeKorisnikaService indRezKorService =
    IndividualneRezervacijeKorisnikaService();

class _RezervacijePageState extends State<RezervacijePage> {
  DioClient dioCL = DioClient();
  /* late Future<List<IndividualneRezervacijeKorisnikaResponse>> listaIndRezKor;

  @override
  void initState() {
    listaIndRezKor = indRezKorService.getIndividualneRezervacijeKorisnika(
        dioCL, idKorisnika);

    super.initState();
  }*/

  int _curr = 0;
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    List<Widget> _list = <Widget>[
      const Center(child: PrikazIndividualnihRezervacijaKorisnika()),
      const Center(child: PrikazGrupnihRezervacijaKorisnika()),
    ];

    double sirina = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                    width: sirina * 0.45,
                    height: 50,
                    margin: const EdgeInsets.only(
                        top: 10, left: 5, right: 2, bottom: 10),
                    decoration: BoxDecoration(
                      color: _curr == 0 ? Colors.black12 : null,
                    ),
                    child: const Center(
                        child: Text(
                      'Individualne',
                      style: TextStyle(
                          fontSize: 25,
                          color: scaffoldBoja,
                          fontWeight: FontWeight.bold),
                    ))),
              ),
              Expanded(
                child: Container(
                    width: sirina * 0.45,
                    height: 50,
                    margin: const EdgeInsets.only(
                        left: 2, right: 5, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: _curr == 1 ? Colors.black12 : null),
                    child: const Center(
                      child: Text(
                        'Grupne',
                        style: TextStyle(
                            fontSize: 25,
                            color: scaffoldBoja,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              )
            ],
          ),
          Expanded(
            child: PageView(
              children: _list,
              scrollDirection: Axis.horizontal,

              // reverse: true,
              // physics: BouncingScrollPhysics(),
              controller: controller,
              onPageChanged: (num) {
                setState(() {
                  _curr = num;
                  print(_curr);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
