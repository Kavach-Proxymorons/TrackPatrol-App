import 'package:Trackpatrol/screens/loginScreen.dart';
import 'package:flutter/material.dart';

import '../auth_services/login_service.dart';
import '../models/login_model.dart';

class AuthProvider with ChangeNotifier {
  String? token;
  String? name;
  Login? loginData = Login();
  dologin(String username, String password) async {
    loginData = await login(username, password);
    token = loginData!.data!.token!;
    name = loginData!.data!.user!.name!;
    notifyListeners();
  }
}
