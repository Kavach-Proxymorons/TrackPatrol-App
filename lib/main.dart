import 'package:Trackpatrol/screens/dutiesPage.dart';
import 'package:flutter/material.dart';
import 'package:Trackpatrol/screens/loginScreen.dart';
import 'package:Trackpatrol/screens/splashScreen.dart';

import 'maps/maps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/duties',
      routes: {
        '/login': (context) => Login(), // '/login': (context) => const Login(),
        '/duties': (context) => const DutiesPage(),
        '/mapRender': (context) => const MapRender(),
        '/splashScreen': (context) => const SplashScreen(),
      },
    );
  }
}
