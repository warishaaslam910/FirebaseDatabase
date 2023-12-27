class Chatuser {
  Chatuser({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.isOnline,
    required this.email,
    required this.pushToken,
    required this.lastactive,
  });
  late String image;
  late String about;
  late String name;
  late String createdAt;
  late String id;
  late bool isOnline;
  late String email;
  late String pushToken;
  late String lastactive;

  Chatuser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    isOnline = json['is_online'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
    lastactive = json['lastactive'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['about'] = about;
    _data['name'] = name;
    _data['created_at'] = createdAt;
    _data['id'] = id;
    _data['is_online'] = isOnline;
    _data['email'] = email;
    _data['push_token'] = pushToken;
    _data['lastactive'] = lastactive;
    return _data;
  }
}
