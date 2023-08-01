import 'dart:async';

import 'package:flutter/material.dart';

import '../dutyServices/pushLocationService.dart';
import '../screens/dutiesPage.dart';
import '../screens/loginScreen.dart';

class DutyTimerProvider with ChangeNotifier {
  Timer? timer;
  void startRepeatedFunctionCall() {
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      pushLoc(token!, shiftID!); // Call your function here
    });
    notifyListeners();
  }

  void stopPushingGPS() {
    timer!.cancel();
    notifyListeners();
  }
}
