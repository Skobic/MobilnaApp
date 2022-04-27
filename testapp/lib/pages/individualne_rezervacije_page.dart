import 'package:flutter/material.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/api/individualne_rezervacije_korisnika_service.dart';
import 'package:testapp/models/responses/individualne_rezervacije_korisnika_response.dart';
import 'package:testapp/Login.dart';
import 'package:testapp/widgets/individualna_rezervacija_card.dart';

class PrikazIndividualnihRezervacijaKorisnika extends StatefulWidget {
  const PrikazIndividualnihRezervacijaKorisnika({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PrikazIndividualnihRezervacijaKorisnikaState();
  }
}

IndividualneRezervacijeKorisnikaService indRezKorService =
    IndividualneRezervacijeKorisnikaService();

class _PrikazIndividualnihRezervacijaKorisnikaState
    extends State<PrikazIndividualnihRezervacijaKorisnika> {
  DioClient dioCL = DioClient();
  late Future<List<IndividualneRezervacijeKorisnikaResponse>> listaIndRezKor;

  @override
  void initState() {
    listaIndRezKor = indRezKorService.getIndividualneRezervacijeKorisnika(
        dioCL, idKorisnika);

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
            color: Colors.white,
          ),
          Container(
            color: Colors.white,
            child:
                FutureBuilder<List<IndividualneRezervacijeKorisnikaResponse>>(
                    future: listaIndRezKor,
                    initialData: null,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                            height: 120,
                            width: 120,
                            child: Center(child: CircularProgressIndicator()));
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData &&
                            snapshot.data.toString() != '[]') {
                          //print(snapshot.data);
                          List<IndividualneRezervacijeKorisnikaResponse>? list =
                              snapshot.data?.toList();

                          for (int i = 0; i < list!.length; i++) {
                            if (list[i].vrijemeOtkazivanja != null ||
                                (list[i]
                                    .vrijemeVazenjaDo
                                    .isBefore(DateTime.now())) ||
                                (list[i].vrijemePotvrde != null &&
                                    list[i]
                                        .vrijemePotvrde!
                                        .isAfter(DateTime.now()))) {
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
                                    return IndividualnaRezervacijaKorisnikaCard(
                                        funkcijaOsvjezavanja: refresh,
                                        indRezKorData: list[index],
                                        // index: snapshot.data![index].id,
                                        index: list[index].id,
                                        funkcijaBrisanja:
                                            obrisiIndividualnuRezervacijuKorisnika);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 15,
                                        width: 40,
                                      ),
                                  itemCount: snapshot.data!.length),
                              SizedBox(height: 15)
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

  void obrisiIndividualnuRezervacijuKorisnika(int ind) async {
    var response = await indRezKorService.deleteRezervacija(
        mjestoId: 4, dioClient: dioCL, rezervacijaId: ind);
    if (response.statusCode == 200 || response.statusCode == 204) {
      setState(() {
        listaIndRezKor = indRezKorService.getIndividualneRezervacijeKorisnika(
            dioCL, idKorisnika);
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
        listaIndRezKor = indRezKorService.getIndividualneRezervacijeKorisnika(
            dioCL, idKorisnika);
      });
    }
  }

  void refresh() {
    setState(() {
      listaIndRezKor = indRezKorService.getIndividualneRezervacijeKorisnika(
          dioCL, idKorisnika);
    });
  }
}
