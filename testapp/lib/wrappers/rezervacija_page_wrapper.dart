import 'package:flutter/material.dart';

import '../pages/rezervacije_page.dart';

class RezervacijePageWrapper extends StatelessWidget {
  const RezervacijePageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'rezervacije',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case 'rezervacije':
            builder = (BuildContext context) => const RezervacijePage();
            break;

          default:
            throw Exception('Invalid route:}');
        }
        return MaterialPageRoute<void>(
            builder: builder, settings: settings, maintainState: false);
      },
    );
  }
}
