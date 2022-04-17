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
  var accessToken = prefs.getString('accessToken');
  var refreshToken = prefs.getString('refreshToken');

  bool isLoggedIn = (accessToken != null && refreshToken != null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (const LoginDemo()),
        // : PocetnaStrana()),
        //home: const LoginDemo(),
        routes: {
          '/LoginPage': (context) => const LoginDemo(),
        });
  }
}
