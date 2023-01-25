import 'package:flutter/material.dart';
import 'package:test_project_session_3/repository/reservation_repository.dart';

class ReservationModel with ChangeNotifier {
  bool isLoading = false;
  var reservations = [];
  final _reservationRepository = ReservationRepository();

  ReservationModel(){
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();

    reservations = await _reservationRepository.fetch();
    isLoading = false;
    notifyListeners();
  }
}