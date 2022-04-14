import 'package:flutter/material.dart';

import '../pages/pregled_citaonice_page.dart';

class PregledCitaonicePageWrapper extends StatelessWidget {
  const PregledCitaonicePageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'pregled_citaonice',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          // case 'pregled_citaonice':
          //   builder = (BuildContext context) => PregledCitaonicePage();
          //   break;
          default:
            throw Exception('Invalid route:}');
        }
        // return MaterialPageRoute<void>(
        //     builder: builder, settings: settings, maintainState: false);
      },
    );
  }
}
