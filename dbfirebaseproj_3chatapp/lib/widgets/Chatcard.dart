import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbfirebaseproj_3chatapp/main.dart';
import 'package:dbfirebaseproj_3chatapp/models/Chatuser.dart';
import 'package:flutter/material.dart';

class Chatcard extends StatefulWidget {
  final Chatuser user;
  const Chatcard({super.key, required this.user});

  @override
  State<Chatcard> createState() => _ChatcardState();
}

late Size mq;

class _ChatcardState extends State<Chatcard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: mq.width * .01, vertical: 2),
      child: InkWell(
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .5),
            child: CachedNetworkImage(
              width: mq.width * .095,
              height: mq.height * .095,
              imageUrl: widget.user.image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          title: Text(widget.user.name),
          subtitle: Text(
            widget.user.about,
            maxLines: 1,
          ),
          trailing: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
