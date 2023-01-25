import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project_session_3/user/login_api.dart';

class UserModel with ChangeNotifier {
  var isLoading = true;
  var user;
  var errorText;
  Future login(id, pwd) async {
    var loginUser = await LoginApi.loginAction(id, pwd);
    if(loginUser == null) return;

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(loginUser));
    await getUserData();
  }

  UserModel() {
    getUserData();
  }

  Future getUserData() async {
    var prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString("user");
    if(userData != null) {
      user = jsonDecode(userData);
    }

    isLoading = false;
    notifyListeners();
  }
}