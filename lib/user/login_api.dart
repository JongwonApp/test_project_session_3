import 'package:test_project_session_3/repository/api_manager.dart';

class LoginApi {
  static Future loginAction(String id, String pwd) async {
    var res = await ApiManager.post("api/User/Login", {"id" : id, "pwd" : pwd});
    if(res == null) return null;
    return res;
  }

  static Future logout(String id, String pwd) async {
    var res = await ApiManager.post("api/User/Login", {"id" : id, "pwd" : pwd});
    if(res == null) return null;
    return res;
  }
}

