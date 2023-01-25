import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project_session_3/viewmodel/user_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    TextEditingController _idController = TextEditingController();
    TextEditingController _pwdController = TextEditingController();

    return Container(
      decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/background.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.4),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(50,50,50,0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', fit: BoxFit.contain, width: 120),
              SizedBox(height: 40),
              Text('IMAGINATION STAY', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  errorText: userModel.errorText ?? null,
                  filled: true, fillColor: Colors.white,
                  hintText: 'ID를 입력해주세요', border: OutlineInputBorder()),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _pwdController,
                decoration: InputDecoration(
                    filled: true, fillColor: Colors.white,
                    hintText: 'PW를 입력해주세요', border: OutlineInputBorder()),
              ),
              SizedBox(height: 8),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      var id = _idController.text;
                      var pwd = _pwdController.text;

                      await userModel.login(id, pwd);
                      if(userModel.user == null) {
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("알림"),
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                            contentPadding: EdgeInsets.zero,
                            content: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                              Container(
                                padding: EdgeInsets.all(24),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text('알림', style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 8),
                                  Text('아이디 또는 비밀번호를 다시 입력해주세요.'),
                                  SizedBox(height: 40),
                                  Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    child: TextButton(onPressed: () => Navigator.pop(context), child: Text("확인", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)))
                                  )
                                ])
                              ),
                            ],),
                          );
                        });
                        return;
                      }
                      Navigator.pushNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      padding: EdgeInsets.all(15),
                    ),
                    child: Text('로그인', style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 16))
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
