import 'dart:convert';
import 'dart:developer';
import '../../models/login_model.dart';
import 'package:http/http.dart' as http;

import '../constants/links/apiProductionLink.dart';

Future<void> offlineDataPush(
    List<String?> offlineData, String token, String shiftID) async {
  var response = await http.post(
      Uri.parse("$prodLink/api/v1/app/duty/$shiftID/push_gps_data_bulk"),
      body: jsonEncode({'gps_data': offlineData}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
  if (response.statusCode == 200) {
    log("offline-data-pushed");
  } else {
    log("offline data not pushed");
  }
}
