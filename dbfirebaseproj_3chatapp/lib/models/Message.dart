class Messages {
  Messages({
    required this.toid,
    required this.msg,
    required this.read,
    required this.type,
    required this.sent,
    required this.fromid,
    required String imageUrl,
  });
  late final String toid;
  late final String msg;
  late final String read;
  late final Type type;
  late final String sent;
  late final String fromid;

  Messages.fromJson(Map<String, dynamic> json) {
    toid = json['toid'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();

    sent = json['sent'].toString();
    fromid = json['fromid'].toString();
    /////for message type we use enum as it can be either a text or an image
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toid'] = toid;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = type;
    data['sent'] = sent;
    data['fromid'] = fromid;
    return data;
  }
}

enum Type { text, image }
