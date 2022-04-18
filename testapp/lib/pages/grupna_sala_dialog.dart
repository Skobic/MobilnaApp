import 'package:flutter/material.dart';
import 'package:testapp/api/rezervacija_service.dart';

import '../api/dio_client.dart';
import '../models/responses/grupna_sala_response.dart';

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
  DateTime? reservationDate;
  SnackBarMessage? snackMessage;
  RezervacijaService rezervacijaService = RezervacijaService();
  DioClient dioCL = DioClient();

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
            // SizedBox(
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       shrinkWrap: false,
            //       itemCount: widget.salaData.listaRezervacija.length,
            //       itemBuilder: (context, index) => RezervacijaTile(
            //           index,
            //           widget.salaData.listaRezervacija.length,
            //           widget.salaData.listaRezervacija[index].odVrijeme.hour
            //                   .toString() +
            //               ':' +
            //               widget
            //                   .salaData.listaRezervacija[index].odVrijeme.minute
            //                   .toString(),
            //           widget.salaData.listaRezervacija[index].doVrijeme.hour
            //                   .toString() +
            //               ':' +
            //               widget
            //                   .salaData.listaRezervacija[index].doVrijeme.minute
            //                   .toString()),
            //     ),
            //     height: 80),
            const Divider(
              height: 30,
              thickness: 2,
              indent: 10,
              endIndent: 10,
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
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.grey[200]!)),
                              child: Text(
                                getTimeText('f'),
                              ),
                              onPressed: () => pickTime(context, 'f'),
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
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.grey[200]!)),
                              child: (reservationDate == null)
                                  ? Text(
                                      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}')
                                  : Text(
                                      '${reservationDate!.day}/${reservationDate!.month}/${reservationDate!.year}'),
                              onPressed: () => pickDate(context),
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
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.grey[200]!)),
                              child: Text(
                                getTimeText('t'),
                              ),
                              onPressed: () => pickTime(context, 't'),
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
                                  () {
                                SnackBar incorrectTimeMessage = SnackBar(
                                    content: (snackMessage ==
                                            SnackBarMessage
                                                .incorrectDefinitionError)
                                        ? const Text(
                                            "Neispravno definisano vrijeme!")
                                        : const Text(
                                            "Rezervacija van radnog vremena!"),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor:
                                        const Color.fromARGB(255, 216, 53, 53));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(incorrectTimeMessage);
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
        initialDate: (reservationDate == null) ? currentDate : reservationDate!,
        firstDate: currentDate,
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 3));

    if (newDate == null) return;

    setState(() => {reservationDate = newDate});
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
