import 'package:Trackpatrol/app.dart';
import 'package:Trackpatrol/providers/authProvider.dart';
import 'package:Trackpatrol/providers/dutyTimerProvider.dart';
import 'package:Trackpatrol/providers/locationProvider.dart';
import 'package:Trackpatrol/providers/offline-provider.dart';
import 'package:Trackpatrol/screens/dutiesPage.dart';
import 'package:flutter/material.dart';
import 'package:Trackpatrol/screens/loginScreen.dart';
import 'package:Trackpatrol/screens/splashScreen.dart';
import 'package:overlay_support/overlay_support.dart';
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
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider<DutyTimerProvider>(
            create: (_) => DutyTimerProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => OfflineProvider()),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          theme: ThemeData(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(
            prefs: prefs,
          ),
        ),
      )));
}
