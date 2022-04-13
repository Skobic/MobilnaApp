import 'package:flutter/material.dart';
import 'package:testapp/widgets/citaonica_card.dart';

class CitaonicePage extends StatefulWidget {
  const CitaonicePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CitaonicePageState();
  }
}

class _CitaonicePageState extends State<CitaonicePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    return const CitaonicaCard();
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 25);
                  },
                  itemCount: 3),
              const SizedBox(height: 30),
            ],
          ),
        ));
  }
}
