import 'package:flutter/material.dart';

import '../pages/citaonice_page.dart';
import '../pages/pregled_citaonice_page.dart';

class CitaonicePageWrapper extends StatelessWidget {
  const CitaonicePageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'citaonice',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case 'citaonice':
            builder = (BuildContext context) => const CitaonicePage();
            break;
          // case 'pregled_citaonice':
          //   builder = (BuildContext context) => PregledCitaonicePage();
          //   break;
          default:
            throw Exception('Invalid route:}');
        }
        return MaterialPageRoute<void>(
            builder: builder, settings: settings, maintainState: false);
      },
    );
  }
}
