import 'dart:async';

import 'package:Trackpatrol/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dutyServices/pushLocationService.dart';
import '../screens/dutiesPage.dart';

class DutyTimerProvider with ChangeNotifier {
  Timer? timer;
  String dutyStarted = "false";
  void startRepeatedFunctionCall(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);

    timer = Timer.periodic(const Duration(seconds: 7), (Timer t) {
      pushLoc(provider.token!, provider.shiftID!); // Call your function here
    });
    notifyListeners();
  }

  void stopPushingGPS() {
    timer!.cancel();
    notifyListeners();
  }

  updateDutyStartFlag(String dutyStarted) {
    this.dutyStarted = dutyStarted;
    notifyListeners();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('dutyStarted') != null) {
      dutyStarted = prefs.getString('dutyStarted').toString();
      notifyListeners();
    }
  }
}
