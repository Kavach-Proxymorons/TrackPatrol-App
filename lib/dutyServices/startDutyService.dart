import 'dart:developer';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dutyStartedModel.dart';

Future<DutyStartedModel?> startDuty(
    String token, String shiftID, String time) async {
  var response = await http.post(
      Uri.parse(
          "https://trackpatrol.onrender.com/api/v1/app/duty/$shiftID/start_duty"),
      body: jsonEncode({'time': time}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
  if (response.statusCode == 200) {
    log(response.body);
    return DutyStartedModel.fromJson(
      jsonDecode(response.body),
    );
  } else {
    log("duty started api error");
    log(response.statusCode.toString());
    return null;
  }
}
