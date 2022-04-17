import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/api/rezervacija_service.dart';
import 'package:testapp/models/responses/rezervacija_mjesta_response.dart';

import '../models/responses/mjesto_response.dart';
import '../widgets/rezervacija_tile.dart';
import 'pregled_individualne_sale.dart';

class MjestoDialog extends StatefulWidget {
  final MjestoResponse data;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  final DateTime date;

  MjestoDialog(
      {Key? key,
      required this.data,
      required this.date,
      this.fromTime,
      this.toTime})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MjestoDialogState();
  }
}

class _MjestoDialogState extends State<MjestoDialog> {
  RezervacijaService rezervacijaService = RezervacijaService();
  DioClient dioCL = DioClient();
  late Future<List<RezervacijaMjestaResponse>> listaRezervacija;

  @override
  void initState() {
    super.initState();
    listaRezervacija = rezervacijaService.getRezervacijeMjesta(
        dioCL,
        widget.data.id.toString(),
        DateTime(widget.date.year, widget.date.month, widget.date.day, 00, 00),
        DateTime(widget.date.year, widget.date.month, widget.date.day, 23, 59));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.0))),
      backgroundColor: Colors.grey[300],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(
              'Mjesto ${widget.data.brojMjesta}',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
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
                  return SizedBox(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: false,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => RezervacijaTile(
                            index,
                            snapshot.data!.length,
                            TimeOfDay(
                                hour:
                                    snapshot.data![index].vrijemeVazenjaOd.hour,
                                minute: snapshot
                                    .data![index].vrijemeVazenjaOd.minute),
                            TimeOfDay(
                                hour:
                                    snapshot.data![index].vrijemeVazenjaDo.hour,
                                minute: snapshot
                                    .data![index].vrijemeVazenjaDo.minute)),
                      ),
                      height: 80);
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
          Column(
            children: [
              Row(
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(9, 9, 0, 9),
                      child: Text('Datum:',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Text(
                      '${widget.date.day}/${widget.date.month}/${widget.date.year}',
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ],
              ),
              //const SizedBox(width: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.fromLTRB(9, 9, 0, 9),
                          child: Text('Vrijeme:',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))),
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text(
                          getVrijeme('f') + ' - ' + getVrijeme('t'),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12.0),
                        child: InkWell(
                          splashColor: Colors.green[300],
                          borderRadius: BorderRadius.circular(12.0),
                          onTap: () async {
                            if (isFree()) {
                              Response? odgovor;
                              try {
                                odgovor = await rezervacijaService
                                    .kreirajRezervacijuMjesta(
                                        dioCL,
                                        widget.data.id.toString(),
                                        DateTime(
                                            widget.date.year,
                                            widget.date.month,
                                            widget.date.day,
                                            widget.fromTime!.hour,
                                            widget.fromTime!.minute),
                                        DateTime(
                                            widget.date.year,
                                            widget.date.month,
                                            widget.date.day,
                                            widget.toTime!.hour,
                                            widget.toTime!.minute));

                                if ((odgovor.statusCode == 200 ||
                                    odgovor.statusCode == 201)) {
                                  const snackBar = SnackBar(
                                    duration: Duration(seconds: 3),
                                    content: Text(
                                        'Uspješno kreirana rezervacija!',
                                        style: TextStyle(color: Colors.white)),
                                    backgroundColor:
                                        Color.fromARGB(255, 61, 185, 45),
                                  );

                                  ScaffoldMessenger.of(
                                          scaffoldKey.currentContext!)
                                      .showSnackBar(snackBar);

                                  Navigator.of(context).pop();
                                }
                              } catch (err) {
                                if (odgovor == null) {
                                  print('gressska');
                                }
                                const snackBar = SnackBar(
                                  duration: Duration(seconds: 3),
                                  content: Text(
                                      'Greška pri kreiranju rezervacije!',
                                      style: TextStyle(color: Colors.white)),
                                  backgroundColor:
                                      Color.fromARGB(255, 199, 78, 69),
                                );

                                ScaffoldMessenger.of(
                                        scaffoldKey.currentContext!)
                                    .showSnackBar(snackBar);
                                Navigator.of(context).pop();
                              }
                            } else {
                              const snackBar = SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(
                                    'Vrijeme rezervacije nije definisano!',
                                    style: TextStyle(color: Colors.white)),
                                backgroundColor:
                                    Color.fromARGB(255, 199, 78, 69),
                              );

                              ScaffoldMessenger.of(scaffoldKey.currentContext!)
                                  .showSnackBar(snackBar);
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
                      ))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  // List<Widget> reservationSchedule(Rezervacija r, int ind, int length) {
  //   return <Widget>[
  //     TimelineTile(
  //       axis: TimelineAxis.horizontal,
  //       isFirst: ind == 0 ? true : false,
  //       isLast: false,
  //       beforeLineStyle: const LineStyle(color: Colors.green),
  //       afterLineStyle: const LineStyle(color: Colors.red),
  //       indicatorStyle: const IndicatorStyle(
  //         width: 30,
  //         indicator: Icon(Icons.lock_clock),
  //         padding: EdgeInsets.all(7.0),
  //       ),
  //     ),
  //     TimelineTile(
  //       axis: TimelineAxis.horizontal,
  //       isFirst: false,
  //       isLast: ind == length ? true : false,
  //       beforeLineStyle: const LineStyle(color: Colors.green),
  //       afterLineStyle: const LineStyle(color: Colors.red),
  //       indicatorStyle: const IndicatorStyle(
  //         width: 30,
  //         indicator: Icon(Icons.lock_clock),
  //         padding: EdgeInsets.all(7.0),
  //       ),
  //     )
  //   ];
  // }

  String getVrijeme(String t) {
    if (t == 'f') {
      return (widget.fromTime == null)
          ? 'hh:mm'
          : '${widget.fromTime!.hour.toString().padLeft(2, '0')}:${widget.fromTime!.minute.toString().padLeft(2, '0')}';
    } else {
      return (widget.toTime == null)
          ? 'hh:mm'
          : '${widget.toTime!.hour.toString().padLeft(2, '0')}:${widget.toTime!.minute.toString().padLeft(2, '0')}';
    }
  }

  bool isFree() {
    bool result = true;
    if (widget.fromTime == null || widget.toTime == null) {
      // for (int i = 0; i < widget.mjestoData.listaRezervacija.length; i++) {
      //   if ((widget.mjestoData.listaRezervacija[i].odVrijeme.hour * 60 +
      //               widget.mjestoData.listaRezervacija[i].odVrijeme.minute <
      //           widget.date.hour * 60 + widget.date.minute) &&
      //       (widget.mjestoData.listaRezervacija[i].doVrijeme.hour * 60 +
      //               widget.mjestoData.listaRezervacija[i].doVrijeme.minute >
      //           widget.date.hour * 60 + widget.date.minute)) {
      //     result = false;
      //   }
      // }
      return false;
    } else {
      // var x = widget.fromTime!.hour * 60 + widget.fromTime!.minute;
      // var y = widget.toTime!.hour * 60 + widget.toTime!.minute;
      // for (int i = 0; i < widget.mjestoData.listaRezervacija.length; i++) {
      //   if (((x <
      //               widget.mjestoData.listaRezervacija[i].odVrijeme.hour * 60 +
      //                   widget
      //                       .mjestoData.listaRezervacija[i].odVrijeme.minute) &&
      //           (y <
      //               widget.mjestoData.listaRezervacija[i].odVrijeme.hour * 60 +
      //                   widget
      //                       .mjestoData.listaRezervacija[i].odVrijeme.minute) ||
      //       (x >
      //               widget.mjestoData.listaRezervacija[i].doVrijeme.hour * 60 +
      //                   widget
      //                       .mjestoData.listaRezervacija[i].doVrijeme.minute) &&
      //           (y >
      //               widget.mjestoData.listaRezervacija[i].doVrijeme.hour * 60 +
      //                   widget.mjestoData.listaRezervacija[i].doVrijeme
      //                       .minute))) {
      //     result = true;
      //   } else {
      //     result = false;
      //   }
      // }
      // return result;
      return true;
    }
  }
}
