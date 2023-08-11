import 'dart:convert';
import 'dart:developer';

import 'package:Trackpatrol/location_services/getCurrentLocation.dart';
import 'package:Trackpatrol/providers/authProvider.dart';
import 'package:Trackpatrol/services/offline-push-location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class LocationProvider with ChangeNotifier {
  double? latitude;
  double? longitude;

  getposition() async {
    var position = await getUserCurrentLocation();
    latitude = position.latitude;
    longitude = position.longitude;
    notifyListeners();
  }

  List<String?> offlineData = [];

  updateArray(Position position) {
    offlineData.add(jsonEncode({
      "latitude": position.latitude.toString(),
      "longitude": position.longitude.toString(),
      "timestamp": DateTime.now().toUtc().toString()
    }));
    log("array updated");
    for (int i = 0; i < offlineData.length; i++) {
      log(offlineData.toString());
    }
    notifyListeners();
  }

  pushOfflineLocation(BuildContext context) async {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    await offlineDataPush(
        offlineData, provider.token.toString(), provider.shiftID.toString());
    notifyListeners();
  }

  emptyOfflineData() {
    offlineData.clear();
    notifyListeners();
  }
}
