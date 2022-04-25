import 'package:flutter/material.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/api/obavjestenja_service.dart';
import 'package:testapp/models/responses/obavjestenja_response.dart';
import 'package:testapp/widgets/citaonica_card.dart';
import 'package:testapp/widgets/obavjestenje_card.dart';

class PrikazObavjestenja extends StatefulWidget {
  const PrikazObavjestenja({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PrikazObavjestenjaState();
  }
}

ObavjestenjeService obavjestenjaService = ObavjestenjeService();

class _PrikazObavjestenjaState extends State<PrikazObavjestenja> {
  DioClient dioCL = DioClient();
  late Future<List<ObavjestenjaResponse>> listaObavjestenja;

  @override
  void initState() {
    listaObavjestenja =
        obavjestenjaService.getObavjestenja(dioCL, idCitaonice!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //double visina = MediaQuery.of(context).size.height;
    //print(visina);
    //int brojElemenata = 0;
    //print(brojElemenata);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obavještenja'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<ObavjestenjaResponse>>(
            future: listaObavjestenja,
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
                  List<ObavjestenjaResponse>? list = snapshot.data?.toList();

                  list?.sort((a, b) => a.vrijeme.compareTo(b.vrijeme));

                  //brojElemenata = list.length;
                  // print(brojElemenata);
                  return Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ObavjestenjeCard(
                                obavjestenjeData: list![index]);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
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
                          'Trenutno nema obavještenja za prikazati !',
                          style: TextStyle(fontSize: 30),
                        )),
                  );
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),
      ),
    );
  }
}
