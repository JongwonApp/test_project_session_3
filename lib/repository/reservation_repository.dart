import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project_session_3/model/reservation.dart';
import 'package:test_project_session_3/repository/api_manager.dart';

class ReservationRepository {
  Future<List> fetch() async {
    var prefs = await SharedPreferences.getInstance();
    var user = jsonDecode(prefs.getString('user')!);
    List<Reservation> reservations = [];
    var bookerCode = await ApiManager.get('api/Booker', 'userCode=${user['userCode']}&isUser=true');
    var result = await ApiManager.get('api/Reservation', 'bookercode=$bookerCode');

    for (var e in result) {
      Reservation reservation = Reservation.fromJson(e);
      reservations.add(reservation);
    }

    return reservations..sort((a,b) => a.rating!.compareTo(b.rating!));
  }
}
