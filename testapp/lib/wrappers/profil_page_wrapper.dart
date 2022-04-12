import 'package:flutter/material.dart';

import '../pages/profil_page.dart';

class ProfilPageWrapper extends StatelessWidget {
  const ProfilPageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'profil',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case 'profil':
            builder = (BuildContext context) => const ProfilPage();
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
