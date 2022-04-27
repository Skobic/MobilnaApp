import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/constants/config.dart';
import 'package:testapp/models/responses/obavjestenja_response.dart';

class ObavjestenjeCard extends StatefulWidget {
  final ObavjestenjaResponse obavjestenjeData;
  const ObavjestenjeCard({Key? key, required this.obavjestenjeData})
      : super(key: key);

  @override
  _ObavjestenjeCardState createState() => _ObavjestenjeCardState();
}

class _ObavjestenjeCardState extends State<ObavjestenjeCard> {
  @override
  Widget build(BuildContext context) {
    double sirina = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            width: sirina,
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.only(left: 10, right: 10),
            height: 150,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, right: 15, bottom: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(widget.obavjestenjeData.naslov,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: scaffoldBoja))),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, bottom: 10, right: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('${widget.obavjestenjeData.sadrzaj}',
                          style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(fontSize: 20))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '\nVrijeme : ${widget.obavjestenjeData.vrijeme.hour < 10 ? '0${widget.obavjestenjeData.vrijeme.hour}' : widget.obavjestenjeData.vrijeme.hour}'
                        ':${widget.obavjestenjeData.vrijeme.minute < 10 ? '0${widget.obavjestenjeData.vrijeme.minute}' : widget.obavjestenjeData.vrijeme.minute}'
                        ':${widget.obavjestenjeData.vrijeme.second < 10 ? '0${widget.obavjestenjeData.vrijeme.second}' : widget.obavjestenjeData.vrijeme.second}'
                        '     Datum: ${widget.obavjestenjeData.vrijeme.day < 10 ? '0${widget.obavjestenjeData.vrijeme.day}' : widget.obavjestenjeData.vrijeme.day}'
                        '.'
                        '${widget.obavjestenjeData.vrijeme.month < 10 ? '0${widget.obavjestenjeData.vrijeme.month}' : widget.obavjestenjeData.vrijeme.month}'
                        '.'
                        '${widget.obavjestenjeData.vrijeme.year}.',
                        style: GoogleFonts.ubuntu(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: scaffoldBoja)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
