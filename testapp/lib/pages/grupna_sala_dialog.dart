import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:testapp/api/rezervacija_service.dart';
import 'package:testapp/exceptions/conflict_exception.dart';
import 'package:testapp/exceptions/van_radnogvremena_exception.dart';
import 'package:testapp/models/requests/rezervacija_grupne_sale_request.dart';
import 'package:testapp/widgets/karakteristika_field.dart';

import '../api/dio_client.dart';
import '../models/responses/grupna_sala_response.dart';
import '../models/responses/rezervacija_mjesta_response.dart';
import '../widgets/rezervacija_tile.dart';
import 'pregled_citaonice_page.dart';

enum SnackBarMessage {
  incorrectDefinitionError,
  workTimeOutOfBoundsError,
}

class GrupnaSalaDialog extends StatefulWidget {
  final GrupnaSalaResponse grupnaSalaData;
  const GrupnaSalaDialog({Key? key, required this.grupnaSalaData})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GrupnaSalaDialogState();
}

class _GrupnaSalaDialogState extends State<GrupnaSalaDialog> {
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  DateTime reservationDate = DateTime.now();
  SnackBarMessage? snackMessage;
  RezervacijaService rezervacijaService = RezervacijaService();
  DioClient dioCL = DioClient();
  late FocusNode brojOsobaFocus;
  late FocusNode svrhaFocus;
  TextEditingController brojOsobaController = TextEditingController(text: '');
  TextEditingController svrhaController = TextEditingController(text: '');
  late Future<List<RezervacijaMjestaResponse>> listaRezervacija;

  @override
  void initState() {
    super.initState();
    brojOsobaFocus = FocusNode();
    svrhaFocus = FocusNode();
    listaRezervacija = rezervacijaService.getRezervacijeGrupneSale(
        dioCL,
        widget.grupnaSalaData.id.toString(),
        RezervacijeGrupneSaleRequest(
            vrijemeVazenjaDo: DateTime(reservationDate.year,
                reservationDate.month, reservationDate.day, 23, 59),
            vrijemeVazenjaOd: DateTime(reservationDate.year,
                reservationDate.month, reservationDate.day, 00, 00),
            svrha: '',
            brojOsoba: 1));
  }

  @override
  void dispose() {
    super.dispose();
    brojOsobaFocus.dispose();
    svrhaFocus.dispose();
    brojOsobaController.dispose();
    svrhaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0))),
        backgroundColor: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Text(
                      widget.grupnaSalaData.naziv,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Row(
                          children: [
                            Text(
                              widget.grupnaSalaData.brojMjesta.toString(),
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                            const Icon(Icons.person,
                                size: 18, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              FutureBuilder<List<RezervacijaMjestaResponse>>(
                future: listaRezervacija,
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
                      if (snapshot.data!.isEmpty) {
                        return const Center(child: Text('Nema rezervacija!'));
                      } else {
                        return SizedBox(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: false,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => RezervacijaTile(
                                  index,
                                  snapshot.data!.length,
                                  TimeOfDay(
                                      hour: snapshot
                                          .data![index].vrijemeVazenjaOd.hour,
                                      minute: snapshot.data![index]
                                          .vrijemeVazenjaOd.minute),
                                  TimeOfDay(
                                      hour: snapshot
                                          .data![index].vrijemeVazenjaDo.hour,
                                      minute: snapshot.data![index]
                                          .vrijemeVazenjaDo.minute)),
                            ),
                            height: 80);
                      }
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
              const Divider(
                height: 30,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  width: 400,
                  child: Wrap(
                    spacing: 3.0,
                    runSpacing: 3.0,
                    direction: Axis.horizontal,
                    children: [
                      for (var item in widget.grupnaSalaData.karakteristike)
                        KarakteristikaField(karakteristikeData: item!)
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 20,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 100,
                      child: TextField(
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 7.0),
                            labelText: 'Broj osoba'),
                        focusNode: brojOsobaFocus,
                        controller: brojOsobaController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 7.0),
                            labelText: 'Svrha'),
                        focusNode: svrhaFocus,
                        controller: svrhaController,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  width: double.infinity,
                  height: 110,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 3,
                        left: 3,
                        height: 35,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(9.0, 0, 0, 0),
                              child: Text('Od:',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor:
                                      const Color.fromRGBO(238, 238, 238, 1),
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                ),
                                child: Text(getTimeText('f'),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 66, 66, 66))),
                                onPressed: () {
                                  brojOsobaFocus.unfocus();
                                  svrhaFocus.unfocus();
                                  pickTime(context, 'f');
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 3,
                        right: 15,
                        height: 35,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(9.0, 0, 0, 0),
                              child: Text('Datum:',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor:
                                      const Color.fromRGBO(238, 238, 238, 1),
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                ),
                                child: Text(
                                    '${reservationDate.day}/${reservationDate.month}/${reservationDate.year}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 66, 66, 66))),
                                onPressed: () {
                                  brojOsobaFocus.unfocus();
                                  svrhaFocus.unfocus();
                                  pickDate(context);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        left: 3,
                        bottom: 9,
                        height: 35,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(9.0, 0, 0, 0),
                              child: Text('Do:',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor:
                                      const Color.fromRGBO(238, 238, 238, 1),
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                ),
                                child: Text(getTimeText('t'),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 66, 66, 66))),
                                onPressed: () {
                                  brojOsobaFocus.unfocus();
                                  svrhaFocus.unfocus();
                                  pickTime(context, 't');
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          right: 15,
                          bottom: 9,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(9.0, 0, 0, 0),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12.0),
                              child: InkWell(
                                splashColor: Colors.green[300],
                                borderRadius: BorderRadius.circular(12.0),
                                onTap:
                                    //testDefinedTime()? () {} :
                                    () async {
                                  if (isCorrectTime()) {
                                    svrhaFocus.unfocus();
                                    brojOsobaFocus.unfocus();
                                    //Pokusavam kreirati rezervaciju, u slucaju da se desi error, baca se Exception is rezervacijaService i obradjuje nakon ovog try bloka
                                    try {
                                      Response? odgovor =
                                          await rezervacijaService
                                              .kreirajRezervacijuGrupneSale(
                                        dioCL,
                                        widget.grupnaSalaData.id.toString(),
                                        RezervacijeGrupneSaleRequest(
                                            vrijemeVazenjaOd: DateTime(
                                                reservationDate.year,
                                                reservationDate.month,
                                                reservationDate.day,
                                                fromTime!.hour,
                                                fromTime!.minute,
                                                00),
                                            vrijemeVazenjaDo: DateTime(
                                                reservationDate.year,
                                                reservationDate.month,
                                                reservationDate.day,
                                                toTime!.hour,
                                                toTime!.minute,
                                                00),
                                            svrha: 'a',
                                            brojOsoba: 1),
                                      );
                                      if (odgovor != null) {
                                        if (odgovor.statusCode == 200 ||
                                            odgovor.statusCode == 201) {
                                          const snackBar = SnackBar(
                                            duration: Duration(seconds: 3),
                                            content: Text(
                                                'Uspješno kreirana rezervacija!',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            backgroundColor: Color.fromARGB(
                                                255, 61, 185, 45),
                                          );

                                          ScaffoldMessenger.of(
                                                  citaonicaScaffoldKey
                                                      .currentContext!)
                                              .showSnackBar(snackBar);

                                          Navigator.of(context).pop();
                                        }
                                      }
                                    } on ConflictException catch (err) {
                                      //Nasljedeni exception za 409 statusCode od strane servera
                                      print('Exception..:----> ${err.uzrok}');
                                      const snackBar = SnackBar(
                                        duration: Duration(seconds: 3),
                                        content: Text(
                                            'Postoji rezervacija u datom vremenu!',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        backgroundColor:
                                            Color.fromARGB(255, 216, 53, 53),
                                      );

                                      ScaffoldMessenger.of(citaonicaScaffoldKey
                                              .currentContext!)
                                          .showSnackBar(snackBar);

                                      Navigator.of(context).pop();
                                    } on VanRadnogVremenaException catch (err) {
                                      print('${err.uzrok}');
                                      const snackBar = SnackBar(
                                        duration: Duration(seconds: 3),
                                        content: Text(
                                            'Definisana rezervacija van radnog vremena!',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        backgroundColor:
                                            Color.fromARGB(255, 199, 78, 69),
                                      );

                                      ScaffoldMessenger.of(citaonicaScaffoldKey
                                              .currentContext!)
                                          .showSnackBar(snackBar);
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      //obradjuju se svi ostali izuzeci
                                      print('Exception:----> $e');
                                      const snackBar = SnackBar(
                                        duration: Duration(seconds: 3),
                                        content: Text(
                                            'Greska pri kreiranju rezervacije!',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        backgroundColor:
                                            Color.fromARGB(255, 216, 53, 53),
                                      );

                                      ScaffoldMessenger.of(citaonicaScaffoldKey
                                              .currentContext!)
                                          .showSnackBar(snackBar);

                                      Navigator.of(context).pop();
                                    }
                                  } else {
                                    //u slucaju da vrijeme nije dobro definisano
                                    SnackBar incorrectTimeMessage = SnackBar(
                                        content: (snackMessage ==
                                                SnackBarMessage
                                                    .incorrectDefinitionError)
                                            ? const Text(
                                                "Neispravno definisano vrijeme!")
                                            : const Text(
                                                "Rezervacija van radnog vremena!"),
                                        duration: const Duration(seconds: 2),
                                        backgroundColor: const Color.fromARGB(
                                            255, 216, 53, 53));
                                    ScaffoldMessenger.of(citaonicaScaffoldKey
                                            .currentContext!)
                                        .showSnackBar(incorrectTimeMessage);
                                  }
                                },
                                child: Ink(
                                  width: 70,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.green[600]),
                                  child: Center(
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          color: Colors.grey[300],
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        ));
  }

  Future pickTime(BuildContext context, String t) async {
    final TimeOfDay initialTime;
    final TimeOfDay currentTime = TimeOfDay.now();
    if (t == 'f') {
      if (fromTime == null) {
        initialTime = currentTime;
      } else {
        initialTime = fromTime!;
      }
    } else {
      if (toTime == null) {
        initialTime = currentTime;
      } else {
        initialTime = toTime!;
      }
    }
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime == null) return;
    if (t == 'f') {
      setState(() => {fromTime = newTime});
    } else {
      setState(() => {toTime = newTime});
    }
  }

  Future pickDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: reservationDate,
        firstDate: currentDate,
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 3));

    if (newDate == null) return;

    setState(() => {
          reservationDate = newDate,
          listaRezervacija = rezervacijaService.getRezervacijeGrupneSale(
              dioCL,
              widget.grupnaSalaData.id.toString(),
              RezervacijeGrupneSaleRequest(
                  vrijemeVazenjaDo: DateTime(reservationDate.year,
                      reservationDate.month, reservationDate.day, 23, 59),
                  vrijemeVazenjaOd: DateTime(reservationDate.year,
                      reservationDate.month, reservationDate.day, 00, 00),
                  svrha: '',
                  brojOsoba: 1))
        });
  }

  String getTimeText(String t) {
    if (t == 'f') {
      if (fromTime == null) {
        return 'hh:mm';
      } else {
        final h = fromTime!.hour.toString().padLeft(2, '0');
        final m = fromTime!.minute.toString().padLeft(2, '0');

        return '$h:$m';
      }
    } else {
      if (toTime == null) {
        return 'hh:mm';
      } else {
        final h = toTime!.hour.toString().padLeft(2, '0');
        final m = toTime!.minute.toString().padLeft(2, '0');
        return '$h:$m';
      }
    }
  }

  bool isCorrectTime() {
    if (fromTime != null && toTime != null) {
      var diff = (toTime!.hour * 60 + toTime!.minute) -
          (fromTime!.hour * 60 + fromTime!.minute);
      if (diff <= 3 * 60 && diff >= (0 * 60 + 15)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // bool isInWorkTime() {
  //   var begginingWorkTime =
  //       widget.radnoVr.start.hour * 60 + widget.radnoVr.start.minute;
  //   var endingWorkTime =
  //       widget.radnoVr.end.hour * 60 + widget.radnoVr.end.minute;
  //   var begginingOfReservation = fromTime!.hour * 60 + fromTime!.minute;
  //   var endingOfReservation = toTime!.hour * 60 + toTime!.minute;
  //   if ((begginingOfReservation > begginingWorkTime &&
  //           begginingOfReservation < endingWorkTime) &&
  //       (endingOfReservation > begginingWorkTime &&
  //           endingOfReservation < endingWorkTime)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // bool testDefinedTime() {
  //   if (!isCorrectTime()) {
  //     snackMessage = SnackBarMessage.incorrectDefinitionError;
  //     return false;
  //   } else {
  //     if (!isInWorkTime()) {
  //       snackMessage = SnackBarMessage.workTimeOutOfBoundsError;
  //       return false;
  //     } else {
  //       return true;
  //     }
  //   }
  // }
}
