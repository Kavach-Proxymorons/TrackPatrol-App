import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../models/allDutiesmodel.dart';

class GetDutyclass {
  Future<AllDuties?> getDuties(String token) async {
    var response = await http.get(
        Uri.parse(
            "https://trackpatrol.onrender.com/api/v1/app/duty/?page=1&limit=10000"),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      log(response.body);
      return AllDuties.fromJson(jsonDecode(response.body));
    } else {
      log("error getting duties");
      log(response.statusCode.toString());
      return null;
    }
  }
}
