import 'dart:async';

import 'package:Trackpatrol/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dutyServices/pushLocationService.dart';
import '../screens/dutiesPage.dart';
import '../screens/loginScreen.dart';

class DutyTimerProvider with ChangeNotifier {
  Timer? timer;

  void startRepeatedFunctionCall(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      pushLoc(provider.token!, shiftID!); // Call your function here
    });
    notifyListeners();
  }

  void stopPushingGPS() {
    timer!.cancel();
    notifyListeners();
  }
}
