import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarModel with ChangeNotifier {
  var checkIn;
  var checkOut;
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
    // notifyListeners();
    return {"year": year, "month": month, "startWeek": startWeek,"totalDay" : totalDay,"totalWeek" : totalWeek};
  }

  void checkInChange(c) {
    checkIn = c;
    notifyListeners();
  }
  void checkOutChange(c) {
    checkOut = c;
    notifyListeners();
  }

}