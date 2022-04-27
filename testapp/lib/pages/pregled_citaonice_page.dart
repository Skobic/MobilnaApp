import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/api/grupna_sala_service.dart';
import 'package:testapp/api/individualna_sala_service.dart';
import 'package:testapp/constants/config.dart';
import 'package:testapp/models/responses/individualna_sala_response.dart';
import 'package:testapp/widgets/individualna_sala_tile.dart';
import 'package:testapp/widgets/informacije_citaonice.dart';

import '../api/dio_client.dart';
import '../models/responses/citaonica_response.dart';
import '../models/responses/grupna_sala_response.dart';
import '../widgets/grupna_sala_tile.dart';

class PregledCitaonicePage extends StatefulWidget {
  final CitaonicaResponse citaonicaData;

  const PregledCitaonicePage({Key? key, required this.citaonicaData})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PregledCitaonicePageState();
  }
}

final GlobalKey<ScaffoldState> citaonicaScaffoldKey =
    GlobalKey<ScaffoldState>();

class _PregledCitaonicePageState extends State<PregledCitaonicePage> {
  DioClient dioCL = DioClient();
  IndividualneSaleService individualneSaleService = IndividualneSaleService();
  GrupneSaleService grupneSaleService = GrupneSaleService();
  late Future<List<IndividualnaSalaResponse>> listaIndSala;
  late Future<List<GrupnaSalaResponse>> listaGrupSala;

  @override
  void initState() {
    listaIndSala = individualneSaleService.getIndividualneSale(
        dioCL, widget.citaonicaData.id.toString());
    listaGrupSala = grupneSaleService.getGrupneSale(
        dioCL, widget.citaonicaData.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: citaonicaScaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.citaonicaData.name,
          style: GoogleFonts.ubuntu(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 254, 254, 254),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: scaffoldBoja,
      ),
      bottomNavigationBar: null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InformacijeCitaonice(citaonicaData: widget.citaonicaData),
            ),
            const Divider(
              height: 15,
              thickness: 2.7,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Individualne sale',
                style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: podnaslovBoja,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<IndividualnaSalaResponse>>(
              future: listaIndSala,
              initialData: null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Center(child: CircularProgressIndicator())),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return IndividualnaSalaTile(
                              individualnaSalaData: snapshot.data![index]);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 6,
                        ),
                      ),
                    );
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Grupne sale',
                style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: podnaslovBoja,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<GrupnaSalaResponse>>(
              future: listaGrupSala,
              initialData: null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Center(child: CircularProgressIndicator())),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GrupnaSalaTile(
                              grupnaSalaData: snapshot.data![index]);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 6,
                        ),
                      ),
                    );
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
