import 'dart:convert';
import 'dart:developer';
import '../../models/login_model.dart';
import 'package:http/http.dart' as http;

import '../constants/links/apiProductionLink.dart';

Future<Login?> login(String username, String password) async {
  var response = await http.post(Uri.parse("$prodLink/api/v1/auth/login"),
      body: jsonEncode({"username": username, "password": password}),
      headers: {'Content-Type': 'application/json'});
  if (response.statusCode == 200) {
    log(response.body);
    return Login.fromJson(
      jsonDecode(response.body),
    );
  } else {
    log("API not fetched");
    log(response.statusCode.toString());
    return null;
  }
}
