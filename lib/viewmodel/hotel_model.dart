import 'package:flutter/material.dart';
import 'package:test_project_session_3/repository/hotel_repository.dart';

class HotelModel with ChangeNotifier {
  bool isLoading = false;
  List hotels = [];

  int page = 1;
  final _hotelRepository = HotelRepository();

  void nextPage() {
    page++;
    fetch();
  }

  HotelModel(){
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();

    for(var e in await _hotelRepository.fetch()) {
      hotels.add(e);
    }
    hotels.sort((a, b) => b.rating.compareTo(a.rating));
    isLoading = false;
    notifyListeners();
  }
}