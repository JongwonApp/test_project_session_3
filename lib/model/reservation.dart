class Reservation {
  Reservation({
    this.reservationCode,
    this.hotelCode,
    this.hotelName,
    this.rating,
    this.address,
    this.checkIn,
    this.checkOut,
    this.amount,
    this.image,
  });

  Reservation.fromJson(dynamic json) {
    reservationCode = json['reservationCode'];
    hotelCode = json['hotelCode'];
    hotelName = json['hotelName'];
    rating = json['rating'];
    address = json['address'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    amount = json['amount'];
    image = json['image'];
  }

  int? reservationCode;
  int? hotelCode;
  String? hotelName;
  double? rating;
  String? address;
  String? checkIn;
  String? checkOut;
  int? amount;
  var image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reservationCode'] = reservationCode;
    map['hotelCode'] = hotelCode;
    map['hotelName'] = hotelName;
    map['rating'] = rating;
    map['address'] = address;
    map['checkIn'] = checkIn;
    map['checkOut'] = checkOut;
    map['amount'] = amount;
    map['image'] = image;
    return map;
  }
}
