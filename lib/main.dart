import 'package:Trackpatrol/providers/authProvider.dart';
import 'package:Trackpatrol/providers/dutyTimerProvider.dart';
import 'package:Trackpatrol/providers/locationProvider.dart';
import 'package:Trackpatrol/screens/dutiesPage.dart';
import 'package:flutter/material.dart';
import 'package:Trackpatrol/screens/loginScreen.dart';
import 'package:Trackpatrol/screens/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'maps/maps.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenPrefs = prefs.getString('token');

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider<DutyTimerProvider>(
            create: (_) => DutyTimerProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: tokenPrefs == null ? LoginScreen() : DutiesPage(),
      )));
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
        '/login': (context) => LoginScreen(),
        '/duties': (context) => const DutiesPage(),
        '/mapRender': (context) => const MapRender(),
        '/splashScreen': (context) => const SplashScreen(),
      },
    );
  }
}
