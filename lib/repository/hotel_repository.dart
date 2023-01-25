import 'package:test_project_session_3/model/hotel.dart';
import 'package:test_project_session_3/repository/api_manager.dart';

class HotelRepository {
  List<Hotel> hotels = [];
  Future<List> fetch([int p = 1, Map? data]) async {
    var request = '';
    if(data != null) {
      request = "address=${data['address']}&checkIn=${data['checkIn']}&checkOut=${data['checkOut']}&noPeople=${data['noPeople']}";
    }
    var pageData = await ApiManager.get("api/Hotel/page", request);
    for(var i = 1; i <= pageData['pageCnt']; i++) {
      var res = await ApiManager.get('api/Hotel', 'page=$i&$request');
      if(res == null) return [];
      for (var e in res) {
        Hotel store = Hotel.fromJson(e);
        hotels.add(store);
      }
    }

    return hotels..sort((a,b) => a.rating!.compareTo(b.rating!));
  }
}

class HotelAddressRepository {
  Future fetch(keyword) async {
    var addressData = await ApiManager.get('api/Address/$keyword');
    if(addressData == null) return [];
    var result = [];
    for(var e in addressData) {
      var addressArr = e['address'].split(' ');
      result.add('${addressArr[0]} ${addressArr[1]}');
    }

    return result.toSet().toList();
  }
}