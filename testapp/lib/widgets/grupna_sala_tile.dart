import 'package:flutter/material.dart';

class GrupnaSalaTile extends StatelessWidget {
  const GrupnaSalaTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      elevation: 4,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        tileColor: const Color.fromARGB(255, 245, 245, 245),
        onTap: () {},
        title: const Text('Grupna Sala',
            style: TextStyle(
                color: Color.fromARGB(255, 86, 86, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: const [
          Text('3',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 116, 116, 116))),
          SizedBox(width: 5),
          Icon(
            Icons.person,
            size: 17,
            color: Color.fromARGB(255, 116, 116, 116),
          ),
          SizedBox(width: 10),
          Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 86, 86, 86))
        ]),
      ),
    );
  }
}
