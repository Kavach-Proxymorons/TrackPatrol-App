import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class OfflineProvider with ChangeNotifier {
  Future<ConnectivityResult> checkConnection() async {
    notifyListeners();
    return await Connectivity().checkConnectivity();
  }

  var previousConnectivity = ConnectivityResult.mobile;

  updatePreviousConnectivity(ConnectivityResult result) {
    previousConnectivity = result;
    notifyListeners();
  }
}
