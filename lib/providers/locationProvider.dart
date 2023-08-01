import 'package:Trackpatrol/location_services/getCurrentLocation.dart';
import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  double? latitude;
  double? longitude;
  getposition() async {
    var position = await getUserCurrentLocation();
    latitude = position.latitude;
    longitude = position.longitude;
    notifyListeners();
  }
}
