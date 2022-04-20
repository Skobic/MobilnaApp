import 'package:flutter/material.dart';
import 'package:testapp/models/responses/karakteristike_sale_response.dart';

class KarakteristikaField extends StatelessWidget {
  final KarakteristikeSaleResponse karakteristikeData;
  const KarakteristikaField({Key? key, required this.karakteristikeData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              karakteristikeData.karakteristikaNaziv,
            ),
          ],
        ));
  }
}
