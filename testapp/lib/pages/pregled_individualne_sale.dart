import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:testapp/constants/config.dart';
import 'package:testapp/constants/constant.dart';
import 'package:testapp/models/responses/individualna_sala_response.dart';
import 'package:testapp/models/responses/mjesto_response.dart';

import '../api/dio_client.dart';
import '../api/mjesto_service.dart';
import '../widgets/mjesto_view.dart';

class IndSalaView extends StatefulWidget {
  const IndSalaView({required this.individualnaSalaData});
  final IndividualnaSalaResponse individualnaSalaData;
  //final List<MjestoResponse> lista;

  @override
  State<StatefulWidget> createState() => _IndSalaViewState();
}

class _IndSalaViewState extends State<IndSalaView> {
  DateTime currentDate = DateTime.now();
  DateTime today = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  TimeOfDay? fromTime;
  TimeOfDay? fromTimeTemp;
  TimeOfDay? toTime;
  TimeOfDay? toTimeTemp;
  TimeOfDay? initialTimeFrom;
  TimeOfDay? initialTimeTo;
  GlobalKey keySlike = GlobalKey();
  MjestoService mjestoService = MjestoService();
  late Future<List<MjestoResponse>> listaMjesta;
  DioClient dioCL = DioClient();

  @override
  void initState() {
    super.initState();

    listaMjesta = mjestoService.getMjesta(
        dioCL,
        widget.individualnaSalaData.id.toString(),
        DateTime.now(),
        DateTime.now().add(const Duration(minutes: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(205, 205, 205, 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255), size: 30),
        title: Text(
          widget.individualnaSalaData.naziv,
          style: GoogleFonts.ubuntu(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: scaffoldBoja,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey[300], boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ]),
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                            ),
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey[200]!)),
                        onPressed: () => pickTime(context, 'f'),
                        child: Text(getTimeText('f'),
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                            ),
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey[200]!)),
                        onPressed: () => pickTime(context, 't'),
                        child: Text(getTimeText('t'),
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                            ),
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey[200]!)),
                        onPressed: () => pickDate(context),
                        child: Text(
                            '${currentDate.day}/${currentDate.month}/${currentDate.year}',
                            style: const TextStyle(fontSize: 15)),
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
                      onTap: isCorrectTime()
                          ? () => confirmDate()
                          : () {
                              SnackBar incorrectTimeMessage = const SnackBar(
                                  content:
                                      Text("Neispravno definisano vrijeme!"),
                                  duration: Duration(seconds: 2),
                                  backgroundColor:
                                      Color.fromARGB(255, 216, 53, 53));
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
                )
              ],
            ),
          ),
          Expanded(
            child: InteractiveViewer(
              minScale: 0.1,
              maxScale: 2.5,
              //boundaryMargin: const EdgeInsets.all(double.infinity),
              constrained: true,
              child: Center(
                  child: FutureBuilder<List<dynamic>>(
                      future: Future.wait([
                        http.get(Uri.parse(
                            'http://10.0.2.2:8080/api/v1/individualne-sale/${widget.individualnaSalaData.id}/slika')),
                        listaMjesta
                      ]),
                      initialData: null,
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                              height: 120,
                              width: 120,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text('Error  : ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.memory(
                                  snapshot.data![0].bodyBytes,
                                  fit: BoxFit.fill,
                                ),
                                for (var item in snapshot.data![1])
                                  Positioned(
                                      top: (MediaQuery.of(context).size.width *
                                              0.5625) *
                                          item.pozicija.y,
                                      left: MediaQuery.of(context).size.width *
                                          item.pozicija.x,
                                      child: MjestoView(
                                        item,
                                        currentDate,
                                        fromTimeTemp,
                                        toTimeTemp,
                                        sizeOfMjesto:
                                            ((getKoeficijentVelicineMjesta(
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width) *
                                                    item.velicina) /
                                                100),
                                      )),
                              ],
                            );
                          } else {
                            return const Center(child: Text('Greska'));
                          }
                        } else {
                          return const Center(child: Text('Greska'));
                        }
                      })),
            ),
          ),
        ],
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: today,
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 3));

    if (newDate == null) return;

    setState(() => {currentDate = newDate});
  }

  Future pickTime(BuildContext context, String t) async {
    final TimeOfDay initialTime;
    if (t == 'f') {
      if (initialTimeFrom == null) {
        initialTime = currentTime;
      } else {
        initialTime = initialTimeFrom!;
      }
    } else {
      if (initialTimeTo == null) {
        initialTime = currentTime;
      } else {
        initialTime = initialTimeTo!;
      }
    }
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime == null) return;
    if (t == 'f') {
      setState(() => {fromTime = newTime, initialTimeFrom = fromTime});
    } else {
      setState(() => {toTime = newTime, initialTimeTo = toTime});
    }
  }

  double getKoeficijentVelicineMjesta(double x) {
    return x * (x * 0.5625);
  }

  String getTimeText(String t) {
    if (t == 'f') {
      if (fromTime == null) {
        return 'Od';
      } else {
        final h = fromTime!.hour.toString().padLeft(2, '0');
        final m = fromTime!.minute.toString().padLeft(2, '0');

        return '$h:$m';
      }
    } else {
      if (toTime == null) {
        return 'Do';
      } else {
        final h = toTime!.hour.toString().padLeft(2, '0');
        final m = toTime!.minute.toString().padLeft(2, '0');
        return '$h:$m';
      }
    }
  }

  void confirmDate() {
    setState(() => {fromTimeTemp = fromTime, toTimeTemp = toTime});
  }

  double getSlikaSize() {
    final RenderBox? render =
        keySlike.currentContext!.findRenderObject() as RenderBox?;
    if (render != null) {
      return render.size.width;
    } else {
      return 0.0;
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

  Future<String?> dohvatiSliku() async {
    Response odgovor = await dioCL.dio.get(
        'http://10.0.2.2:8080/api/v1/individualne-sale/${widget.individualnaSalaData.id}/slika');
    if (odgovor.statusCode == 200) {
      return odgovor.data;
    } else {
      return null;
    }
  }
}
