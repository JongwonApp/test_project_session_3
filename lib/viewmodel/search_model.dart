import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_project_session_3/repository/hotel_repository.dart';

class SearchModel with ChangeNotifier {
  /// search */
  bool isLoading = false;
  Map data = {"address" : null, "checkIn" : null, "checkOut": null, "noPeople" : 1};
  List result = [];

  /// address
  final _hotelAddressRepository = HotelAddressRepository();
  List address = [];
  Future fetchAddress(keyword) async {
    isLoading = true;
    notifyListeners();

    address = await _hotelAddressRepository.fetch(keyword);
    address = address.where((e) => e.contains(keyword)).toList();
    isLoading = false;
    notifyListeners();
  }

  /// checkIn, checkOut
  var typeCheck = 'checkIn';
  var year = DateTime.now().year;
  var month = DateTime.now().month;

  setCalendar([int? year, int? month]) {
    DateTime now = DateTime.now();
    year = year ?? now.year;
    month = month ?? now.month;
    this.year = year;
    this.month = month;

    int startWeek = DateTime(year, month, 1).weekday == 7 ? 0 : DateTime(year, month, 1).weekday;
    int totalDay = int.parse(DateFormat('d').format(DateTime(year, month + 1, 0)));
    int totalWeek = ((totalDay + startWeek) / 7).ceil();
    return {"year": year, "month": month, "startWeek": startWeek,"totalDay" : totalDay,"totalWeek" : totalWeek};
  }

  void checkInChange(c) { data['checkIn'] = c; notifyListeners(); }
  void checkOutChange(c) { data['checkOut'] = c; notifyListeners(); }


  /// guest
  int adult = 1;
  int children = 0;
  void changeAdultCount(bool type) {
    type ? ++adult : (adult <= 1 ? 1 : --adult);
    data['noPeople'] = adult + children;
    notifyListeners();
  }
  void changeChildrenCount(bool type) {
    type ? ++children : (children <= 0 ? 0 : --children);
    data['noPeople'] = adult + children;
    notifyListeners();
  }

  /// result
  final _hotelRepository = HotelRepository();
  Future search() async {
    isLoading = true;
    notifyListeners();

    result = await _hotelRepository.fetch(1, data)..sort((a, b) => b.rating.compareTo(a.rating));
    isLoading = false;
    notifyListeners();
  }
}