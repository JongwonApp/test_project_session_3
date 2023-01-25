import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiManager {
  static String baseUrl = "http://221.147.131.71:9977";

  static Future get(String url, [parameter]) async {
    final response = await http.get(Uri.parse('${ApiManager.baseUrl}/$url?$parameter'));
    print(response.statusCode);
    if(response.statusCode != 200) return null;
    var result = jsonDecode(utf8.decode(response.bodyBytes));
    return result;
  }

  static Future post(String url, data) async {
    final response = await http.post(
      Uri.parse('${ApiManager.baseUrl}/$url'),
      headers: { "Content-Type": "application/json" },
      body: jsonEncode(data),
    );
    if(response.statusCode != 200) return null;
    var res = jsonDecode(utf8.decode(response.bodyBytes));
    return res;
  }
}