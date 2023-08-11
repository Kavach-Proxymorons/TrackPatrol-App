import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:Trackpatrol/providers/authProvider.dart';
import 'package:Trackpatrol/providers/dutyTimerProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializeService(BuildContext context) async {
  Provider.of<AuthProvider>(context, listen: false).getPrefs();
  Provider.of<DutyTimerProvider>(context, listen: false).getPrefs();

  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          isForegroundMode: true,
          autoStart: true,
          autoStartOnBoot: true));
  service.startService();
}

void push_location(BuildContext context) {
  Provider.of<DutyTimerProvider>(context, listen: false)
      .startRepeatedFunctionCall(context);
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: 'Trackpatrol',
            content:
                '''You're being tracked by the Authority \n ${DateTime.now().toIso8601String()}''');
      }
    }
    log('background is running');

    service.invoke('update');
  });
}
