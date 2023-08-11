import 'dart:developer';

import 'package:Trackpatrol/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_services/login_service.dart';
import '../models/login_model.dart';

class AuthProvider with ChangeNotifier {
  String? token;
  String? name;
  Login? loginData = Login();
  String? shiftID;
  dologin(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginData = await login(username, password);
    token = loginData!.data!.token!;
    name = loginData!.data!.user!.name!;
    prefs.setString('token', token.toString());
    notifyListeners();
  }

  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
    notifyListeners();
  }

  updateShiftID(String shiftID) {
    this.shiftID = shiftID.toString();
    notifyListeners();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      token = prefs.getString('token').toString();
    }
    if (prefs.getString('shiftID') != null) {
      shiftID = prefs.getString('shiftID').toString();
    }
    log(token.toString());
    notifyListeners();
  }
}
