import 'package:flutter/material.dart';

class KarakteristikaField extends StatelessWidget {
  const KarakteristikaField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Center(
          child: Text(
            'Karakteristike',
          ),
        ));
  }
}
