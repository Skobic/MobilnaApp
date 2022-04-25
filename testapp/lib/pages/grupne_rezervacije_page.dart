import 'package:flutter/material.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/api/grupne_rezervacije_korisnika_service.dart';
import 'package:testapp/api/individualne_rezervacije_korisnika_service.dart';
import 'package:testapp/models/responses/grupne_rezervacije_korisnika_response.dart';
import 'package:testapp/models/responses/individualne_rezervacije_korisnika_response.dart';
import 'package:testapp/Login.dart';
import 'package:testapp/widgets/grupna_rezervacija_card.dart';
import 'package:testapp/widgets/individualna_rezervacija_card.dart';

class PrikazGrupnihRezervacijaKorisnika extends StatefulWidget {
  const PrikazGrupnihRezervacijaKorisnika({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PrikazGrupnihRezervacijaKorisnikaState();
  }
}

GrupneRezervacijeKorisnikaService grupRezKorService =
    GrupneRezervacijeKorisnikaService();

class _PrikazGrupnihRezervacijaKorisnikaState
    extends State<PrikazGrupnihRezervacijaKorisnika> {
  DioClient dioCL = DioClient();
  late Future<List<GrupneRezervacijeKorisnikaResponse>> listaGrupRezKor;

  @override
  void initState() {
    listaGrupRezKor =
        grupRezKorService.getGrupneRezervacijeKorisnika(dioCL, idKorisnika);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //double visina = MediaQuery.of(context).size.height;
    //print(visina);
    //int brojElemenata = 0;
    //print(brojElemenata);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 8,
            color: Colors.white70,
          ),
          Container(
            color: Colors.white70,
            child: FutureBuilder<List<GrupneRezervacijeKorisnikaResponse>>(
                future: listaGrupRezKor,
                initialData: null,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        height: 120,
                        width: 120,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData &&
                        snapshot.data.toString() != '[]') {
                      //print(snapshot.data);
                      List<GrupneRezervacijeKorisnikaResponse>? list =
                          snapshot.data?.toList();

                      for (int i = 0; i < list!.length; i++) {
                        if (list[i].vrijemeOtkazivanja != null ||
                            (list[i]
                                .vrijemeVazenjaDo
                                .isBefore(DateTime.now())) ||
                            list[i].vrijemePotvrde != null) {
                          list[i].vrijemeVazenjaOd = list[i]
                              .vrijemeVazenjaOd
                              .add(const Duration(days: 15));
                        }
                      }

                      list.sort((a, b) =>
                          a.vrijemeVazenjaOd.compareTo(b.vrijemeVazenjaOd));
                      //brojElemenata = list.length;
                      // print(brojElemenata);
                      return Column(
                        children: [
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GrupnaRezervacijaKorisnikaCard(
                                    idSale: list[index].salaId,
                                    grupRezKorData: list[index],
                                    // index: snapshot.data![index].id,
                                    index: list[index].id,
                                    funkcijaBrisanja:
                                        obrisiGrupnuRezervacijuKorisnika);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                    width: 40,
                                  ),
                              itemCount: snapshot.data!.length),
                        ],
                      );
                    } else {
                      return Center(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            height: 300,
                            child: const Text(
                              'Trenutno nema rezervacija za prikazati !',
                              style: TextStyle(fontSize: 30),
                            )),
                      );
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                }),
          ),
        ],
      ),
    );
  }

  void obrisiGrupnuRezervacijuKorisnika(int ind, int IdSale) async {
    var response = await grupRezKorService.deleteRezervacija(
        salaId: IdSale, dioClient: dioCL, rezervacijaId: ind);
    if (response.statusCode == 200 || response.statusCode == 204) {
      setState(() {
        listaGrupRezKor =
            grupRezKorService.getGrupneRezervacijeKorisnika(dioCL, idKorisnika);
      });
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Greška'),
          content: const Text('Greška prilikom brisanja !',
              style: TextStyle(fontSize: 20)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Da'),
            ),
          ],
        ),
      );

      setState(() {
        listaGrupRezKor =
            grupRezKorService.getGrupneRezervacijeKorisnika(dioCL, idKorisnika);
      });
    }
  }
}
