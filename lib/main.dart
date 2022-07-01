import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_carbure/view/screens/SaisiePrix.dart';
import 'package:tu_carbure/view/screens/main_page.dart';
import 'package:tu_carbure/view/screens/register.dart';
import 'package:tu_carbure/view/screens/stationCreation.dart';
import 'package:tu_carbure/view/viewmodels/stations_viewmodel.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => StationViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TuCarbure',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MainPage(),
      routes: {
        '/creation-station': (context) => StationCreation(),
        '/register': (context) => Register(),
        '/saisie-prix': (context) => SaisiePrix(),
      },
    );
  }
}
