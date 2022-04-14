import 'package:flutter/material.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/widgets/citaonica_card.dart';

import '../api/citaonica_service.dart';
import '../models/responses/citaonica_response.dart';

class CitaonicePage extends StatefulWidget {
  const CitaonicePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CitaonicePageState();
  }
}

class _CitaonicePageState extends State<CitaonicePage> {
  DioClient dioCL = DioClient();
  CitaonicaService citaonicaService = CitaonicaService();
  late Future<List<CitaonicaResponse>> listaCitaonica;

  @override
  void initState() {
    super.initState();
    listaCitaonica = citaonicaService.getCitaonice(dioCL);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              FutureBuilder<List<CitaonicaResponse>>(
                  future: listaCitaonica,
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
                      } else if (snapshot.hasData) {
                        return Column(
                          children: [
                            const SizedBox(height: 50),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CitaonicaCard(
                                      citaonicaData: snapshot.data![index]);
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 40,
                                      width: 40,
                                    ),
                                itemCount: snapshot.data!.length),
                            const SizedBox(height: 40),
                          ],
                        );
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  }),
              const SizedBox(height: 30),
            ],
          ),
        ));
  }
}
