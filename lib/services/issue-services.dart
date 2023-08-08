import 'dart:convert';
import 'dart:developer';
import '../../models/login_model.dart';
import 'package:http/http.dart' as http;

import '../constants/links/apiProductionLink.dart';

Future<bool?> issuePost(
    String token, String issue, String description, String shiftID) async {
  var response = await http.post(
      Uri.parse("$prodLink/api/v1/app/duty/$shiftID/post_issue"),
      body: jsonEncode({"issue_category": issue, "description": description}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
  if (response.statusCode == 200) {
    log(response.body);
    return true;
  } else {
    log("API not fetched");
    log(response.statusCode.toString());
    return null;
  }
}
