import 'dart:convert';
import 'dart:developer';
import 'package:Trackpatrol/constants/links/apiProductionLink.dart';
import 'package:http/http.dart' as http;

import '../models/dutyDetailmodel.dart';

Future<DutyDetailsForDutyID?> getDutiesDetail(
    String token, String shiftID) async {
  var response = await http.get(Uri.parse("$prodLink/api/v1/app/duty/$shiftID"),
      headers: {'Authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    log(response.body);
    log("api for duty detail called");
    return DutyDetailsForDutyID.fromJson(jsonDecode(response.body));
  } else {
    log("error getting duties");
    log(response.statusCode.toString());
    return null;
  }
}
