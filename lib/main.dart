import 'package:Trackpatrol/providers/authProvider.dart';
import 'package:Trackpatrol/providers/dutyTimerProvider.dart';
import 'package:Trackpatrol/providers/locationProvider.dart';
import 'package:Trackpatrol/screens/dutiesPage.dart';
import 'package:flutter/material.dart';
import 'package:Trackpatrol/screens/loginScreen.dart';
import 'package:Trackpatrol/screens/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'maps/maps.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider<DutyTimerProvider>(
          create: (_) => DutyTimerProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
    ],
    child: MyApp(),
  ));
}

const fetchBackground = "fetchBackground";

@pragma('vm:entry-point')
dynamic callbackDispatcher(BuildContext context) {
  final provider = Provider.of<DutyTimerProvider>(context, listen: false);
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        provider.startRepeatedFunctionCall(context);
        break;
    }
    return Future.value(true);
  });
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/duties': (context) => const DutiesPage(),
        '/mapRender': (context) => const MapRender(),
        '/splashScreen': (context) => const SplashScreen(),
      },
    );
  }
}
