class User {
  late String id;
  late String pwd;

  User({
    required this.id,
    required this.pwd
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    pwd = json['pwd'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['pwd'] = pwd;
    return map;
  }
}