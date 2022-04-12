import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/pocetna_strana.dart';
import 'Login.dart';
import 'package:flutter/services.dart';

// ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
var IsLoggedIn;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');

  IsLoggedIn = email;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (IsLoggedIn == null ? const LoginDemo() : const PocetnaStrana()),
        //home: const LoginDemo(),
        routes: {
          '/LoginPage': (context) => const LoginDemo(),
        });
  }
}
