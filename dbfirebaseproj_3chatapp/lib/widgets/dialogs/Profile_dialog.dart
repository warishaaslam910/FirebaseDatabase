import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbfirebaseproj_3chatapp/main.dart';
import 'package:dbfirebaseproj_3chatapp/models/Chatuser.dart';
import 'package:dbfirebaseproj_3chatapp/screens/View_profile.dart';
import 'package:flutter/material.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.user});

  final Chatuser user;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: SizedBox(
        width: mq.width * .6,
        height: mq.height * .35,
        child: Stack(children: [
          //user profile pic
          Positioned(
            left: mq.width * .1,
            top: mq.height * .075,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(mq.height * .25),
              child: CachedNetworkImage(
                width: mq.width * .5,
                fit: BoxFit.cover,
                imageUrl: user.image,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    CircleAvatar(child: Icon(Icons.person)),
              ),
            ),
          ),
          Positioned(
            left: mq.width * .04,
            top: mq.height * .02,
            width: mq.width * .55,
            child: Text(
              user.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
            right: 8,
            top: 4,
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ViewProfileScreen(user: user)));
              },
              minWidth: 0,
              padding: EdgeInsets.all(0),
              shape: CircleBorder(),
              child: Icon(
                Icons.info_outline,
                color: Colors.blue,
                size: 30,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
