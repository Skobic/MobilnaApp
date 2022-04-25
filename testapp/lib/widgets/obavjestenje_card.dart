import 'package:flutter/material.dart';
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
                color: Colors.black26, borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(left: 10, right: 10),
            height: 150,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text('${widget.obavjestenjeData.naslov}',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 22, color: Colors.white)),
                  Text('${widget.obavjestenjeData.sadrzaj}',
                      style: TextStyle(fontSize: 22)),
                  Text('${widget.obavjestenjeData.vrijeme}',
                      style: TextStyle(fontSize: 22))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
