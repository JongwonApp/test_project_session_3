class Hotel {

  Hotel({
    this.hotelName,
    this.rating,
    this.representationImg,
    this.address,
  });

  Hotel.fromJson(dynamic json) {
    hotelName = json['hotelName'];
    rating = json['rating'];
    representationImg = json['representationImg'];
    address = json['address'];
  }

  String? hotelName;
  double? rating;
  Map<String, dynamic>? representationImg;
  String? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotelName'] = hotelName;
    map['rating'] = rating;
    map['representationImg'] = representationImg;
    map['address'] = address;
    return map;
  }
}
