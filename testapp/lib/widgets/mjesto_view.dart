import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testapp/models/responses/mjesto_response.dart';

class MjestoView extends StatefulWidget {
  const MjestoView(this.mjestoData, this.date, this.fromTime, this.toTime,
      {required this.sizeOfMjesto});

  final MjestoResponse mjestoData;
  final DateTime date;
  final TimeOfDay? fromTime;
  final TimeOfDay? toTime;
  final double sizeOfMjesto;

  // static List<Rezervacija> lista = <Rezervacija>[
  //   Rezervacija(1, DateTime.parse("2021-07-20 15:18:04Z"),
  //       DateTime.parse("2021-07-20 16:18:04Z"), 'Sala 1', 'ETF'),
  //   Rezervacija(2, DateTime.parse("2021-07-19 14:13:34Z"),
  //       DateTime.parse("2021-07-19 12:00:54Z"), 'Sala 2', 'Paprikovac'),
  //   Rezervacija(3, DateTime.parse("2021-07-24 10:25:55Z"),
  //       DateTime.parse("2021-07-24 12:18:34Z"), 'Sala 1', 'ETF'),
  //   Rezervacija(4, DateTime.parse("2021-07-22 15:18:04Z"),
  //       DateTime.parse("2021-07-22 16:18:04Z"), 'Sala 1', 'Hodnici'),
  // ];

  @override
  State<StatefulWidget> createState() => _MjestoViewState();
}

class _MjestoViewState extends State<MjestoView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.grey[200],
        onTap: () => showCustomDialog(context),
        child: Stack(
          children: [
            Transform.rotate(
                angle: widget.mjestoData.ugao * math.pi / 180,
                child: Icon(Icons.event_seat,
                    size: sqrt(widget.sizeOfMjesto), color: Colors.red[900])),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                constraints: const BoxConstraints(minWidth: 10, minHeight: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(6)),
                child: Text(widget.mjestoData.id.toString(),
                    style: const TextStyle(fontSize: 8),
                    textAlign: TextAlign.center),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
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
                  'Mjesto ${widget.mjestoData.id}',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // SizedBox(
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       shrinkWrap: false,
              //       itemCount: widget.mjestoData.listaRezervacija.length,
              //       itemBuilder: (context, index) => RezervacijaTile(
              //           index,
              //           widget.mjestoData.listaRezervacija.length,
              //           widget.mjestoData.listaRezervacija[index].odVrijeme.hour
              //                   .toString() +
              //               ':' +
              //               widget.mjestoData.listaRezervacija[index].odVrijeme
              //                   .minute
              //                   .toString(),
              //           widget.mjestoData.listaRezervacija[index].doVrijeme.hour
              //                   .toString() +
              //               ':' +
              //               widget.mjestoData.listaRezervacija[index].doVrijeme
              //                   .minute
              //                   .toString()),
              //     ),
              //     height: 80),
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
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
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
                              onTap: () {},
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
      });

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

  // bool isFree() {
  //   bool result = true;
  //   if (widget.fromTime == null || widget.toTime == null) {
  //     for (int i = 0; i < widget.mjestoData.listaRezervacija.length; i++) {
  //       if ((widget.mjestoData.listaRezervacija[i].odVrijeme.hour * 60 +
  //                   widget.mjestoData.listaRezervacija[i].odVrijeme.minute <
  //               widget.date.hour * 60 + widget.date.minute) &&
  //           (widget.mjestoData.listaRezervacija[i].doVrijeme.hour * 60 +
  //                   widget.mjestoData.listaRezervacija[i].doVrijeme.minute >
  //               widget.date.hour * 60 + widget.date.minute)) {
  //         result = false;
  //       }
  //     }
  //     return result;
  //   } else {
  //     var x = widget.fromTime!.hour * 60 + widget.fromTime!.minute;
  //     var y = widget.toTime!.hour * 60 + widget.toTime!.minute;
  //     for (int i = 0; i < widget.mjestoData.listaRezervacija.length; i++) {
  //       if (((x <
  //                   widget.mjestoData.listaRezervacija[i].odVrijeme.hour * 60 +
  //                       widget
  //                           .mjestoData.listaRezervacija[i].odVrijeme.minute) &&
  //               (y <
  //                   widget.mjestoData.listaRezervacija[i].odVrijeme.hour * 60 +
  //                       widget
  //                           .mjestoData.listaRezervacija[i].odVrijeme.minute) ||
  //           (x >
  //                   widget.mjestoData.listaRezervacija[i].doVrijeme.hour * 60 +
  //                       widget
  //                           .mjestoData.listaRezervacija[i].doVrijeme.minute) &&
  //               (y >
  //                   widget.mjestoData.listaRezervacija[i].doVrijeme.hour * 60 +
  //                       widget.mjestoData.listaRezervacija[i].doVrijeme
  //                           .minute))) {
  //         result = true;
  //       } else {
  //         result = false;
  //       }
  //     }
  //     return result;
  //   }
  // }
}
