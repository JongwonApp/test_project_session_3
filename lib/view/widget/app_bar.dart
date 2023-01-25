import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void logout() async {
//   var prefs = await SharedPreferences.getInstance();
//   prefs.remove('id');
//   prefs.remove('pw');
//   prefs.remove('userCode');
//   prefs.remove('user');
// }

var app_bar = AppBar(title: Row(children: [
  SizedBox(width: 40, child: Image.asset('assets/logo.png', fit: BoxFit.contain),),
  SizedBox(width: 20),
  Text('IMAGINATION STAY')
],),
// actions: [IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {
//   logout();
// })],
);
