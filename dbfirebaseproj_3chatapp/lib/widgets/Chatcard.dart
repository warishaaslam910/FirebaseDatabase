import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbfirebaseproj_3chatapp/helper/Apis.dart';
import 'package:dbfirebaseproj_3chatapp/helper/my_date_util.dart';

import 'package:dbfirebaseproj_3chatapp/models/Chatuser.dart';
import 'package:dbfirebaseproj_3chatapp/models/Message.dart';
import 'package:dbfirebaseproj_3chatapp/widgets/dialogs/Profile_dialog.dart';
import 'package:flutter/material.dart';

import '../screens/Chatscreen.dart';

class Chatcard extends StatefulWidget {
  final Chatuser user;
  const Chatcard({super.key, required this.user});

  @override
  State<Chatcard> createState() => _ChatcardState();
}

late Size mq;

class _ChatcardState extends State<Chatcard> {
  //last msg info (if null --> no msg)
  Messages? _message;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: mq.width * .01, vertical: 2),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          user: widget.user,
                        )));
          },
          child: StreamBuilder(
              stream: APIs.getLastMessage(widget.user),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list = data
                        ?.map((e) =>
                            Messages.fromJson(e.data() as Map<String, dynamic>))
                        .toList() ??
                    [];

                if (list.isNotEmpty) _message = list[0];

                return ListTile(
                  leading: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => ProfileDialog(user: widget.user));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .3),
                      child: CachedNetworkImage(
                        width: mq.width * .055,
                        height: mq.height * .055,
                        imageUrl: widget.user.image,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  title: Text(widget.user.name),
                  subtitle: Text(
                    _message != null
                        ? _message!.type == Type.image
                            ? 'image'
                            : _message!.msg
                        : widget.user.about,
                    maxLines: 1,
                  ),
                  trailing: _message == null
                      ? null
                      : _message!.read.isEmpty &&
                              _message!.fromid != APIs.user.uid
                          ? Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          : Text(
                              MyDateUtil.getLastMessageTime(
                                context: context,
                                time: _message!.sent,
                              ),
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                );
              })),
    );
  }
}
