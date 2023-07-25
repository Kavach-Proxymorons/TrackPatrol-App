import 'package:Trackpatrol/location_services/getCurrentLocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import '../constants/links/apiProductionLink.dart';
import '../models/pushDataLocModel.dart';

Future<PushLoc?> pushLoc(String token, String shiftID) async {
  Position position = await getUserCurrentLocation();
  var response = await http.post(
      Uri.parse("$prodLink/api/v1/app/duty/$shiftID/push_gps_data"),
      body: jsonEncode({
        "latitude": position.latitude.toString(),
        "longitude": position.longitude.toString(),
        "timestamp": DateTime.now().toUtc().toString()
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
  if (response.statusCode == 200) {
    log(response.body);
    return PushLoc.fromJson(
      jsonDecode(response.body),
    );
  } else {
    log("duty push api error");
    log(response.statusCode.toString());
    return null;
  }
}
