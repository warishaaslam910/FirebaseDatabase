//right code

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dbfirebaseproj_3chatapp/helper/Apis.dart';
// import 'package:dbfirebaseproj_3chatapp/helper/my_date_util.dart';
// import 'package:dbfirebaseproj_3chatapp/main.dart';
// import 'package:dbfirebaseproj_3chatapp/models/Message.dart';
// import 'package:dbfirebaseproj_3chatapp/models/message.dart';

// import 'package:flutter/material.dart';

// class Messagecard extends StatefulWidget {
//   const Messagecard({super.key, required this.message});
//   final Messages message;
//   @override
//   State<Messagecard> createState() => _MessagecardState();
// }

// class _MessagecardState extends State<Messagecard> {
//   @override
//   Widget build(BuildContext context) {
//     return APIs.user.uid == widget.message.fromid
//         ? _greenMessage()
//         : _blueMessage();
//   }

//   Widget _blueMessage() {
//     if (widget.message.read.isEmpty) {
//       APIs.updatemessagereadstatus(widget.message );
//       print('msg read updated');
//     }
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Flexible(
//           child: Container(
//             padding: EdgeInsets.all(widget.message.type == Type.image
//                 ? mq.width * .03
//                 : mq.width * .04),
//             margin: EdgeInsets.symmetric(
//                 horizontal: mq.width * .04, vertical: mq.height * .01),
//             decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 186, 216, 241),
//                 border: Border.all(color: Colors.lightBlue),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 )),
//             child: widget.message.type == Type.text
//                 ? Text(
//                     widget.message.msg,
//                     style: TextStyle(fontSize: 15, color: Colors.black),
//                   )
//                 :
//                 //show image
//                 ClipRRect(
//                     borderRadius: BorderRadius.circular(mq.height * .03),
//                     child: CachedNetworkImage(
//                       width: mq.width * .05,
//                       height: mq.height * .05,
//                       imageUrl: widget.message.msg,
//                       placeholder: (context, url) => Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: CircularProgressIndicator(),
//                       ),
//                       errorWidget: (context, url, error) => Icon(
//                         Icons.image,
//                         size: 70,
//                       ),
//                     ),
//                   ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(right: mq.width * .04),
//           child: Text(
//             MyDateUtil.getFormattedTime(
//                 context: context, time: widget.message.sent),
//             style: TextStyle(fontSize: 13, color: Colors.black),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _greenMessage() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             SizedBox(
//               width: mq.width * .04,
//             ),
//             if (widget.message.read.isNotEmpty)
//               Icon(
//                 Icons.done_all_rounded,
//                 color: Colors.blue,
//                 size: 20,
//               ),
//             SizedBox(
//               width: 2,
//             ),
//             Text(
//               MyDateUtil.getFormattedTime(
//                   context: context, time: widget.message.sent),
//               style: TextStyle(fontSize: 13, color: Colors.black),
//             ),
//           ],
//         ),
//         Flexible(
//           child: Container(
//             padding: EdgeInsets.all(widget.message.type == Type.image
//                 ? mq.width * .03
//                 : mq.width * .04),
//             margin: EdgeInsets.symmetric(
//                 horizontal: mq.width * .04, vertical: mq.height * .01),
//             decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 218, 255, 176),
//                 border: Border.all(color: Colors.lightGreen),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                   bottomLeft: Radius.circular(30),
//                 )),
//             child: widget.message.type == Type.text
//                 ? Text(
//                     widget.message.msg,
//                     style: TextStyle(fontSize: 15, color: Colors.black),
//                   )
//                 : ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: CachedNetworkImage(
//                       imageUrl: widget.message.msg,
//                       placeholder: (context, url) => Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                         ),
//                       ),
//                       errorWidget: (context, url, error) => Icon(
//                         Icons.image,
//                         size: 70,
//                       ),
//                     ),
//                   ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbfirebaseproj_3chatapp/helper/Apis.dart';
import 'package:flutter/material.dart';

import '../helper/my_date_util.dart';
import '../main.dart';
import '../models/message.dart';

// for showing single message details
class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Messages message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromid
        ? _greenMessage()
        : _blueMessage();
  }

  // sender or another user message
  Widget _blueMessage() {
    //update last read message if sender and receiver are different
    if (widget.message.read.isEmpty) {
      APIs.updatemessagereadstatus(widget.message);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image
                ? mq.width * .03
                : mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 245, 255),
                border: Border.all(color: Colors.lightBlue),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: widget.message.type == Type.text
                ?
                //show text
                Text(
                    widget.message.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :
                //show image
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.message.msg,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),

        //message time
        Padding(
          padding: EdgeInsets.only(right: mq.width * .04),
          child: Text(
            MyDateUtil.getFormattedTime(
                context: context, time: widget.message.sent),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  // our or user message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message time
        Row(
          children: [
            //for adding some space
            SizedBox(width: mq.width * .04),

            //double tick blue icon for message read
            if (widget.message.read.isNotEmpty)
              const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),

            //for adding some space
            const SizedBox(width: 2),

            //sent time
            Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.sent),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),

        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image
                ? mq.width * .03
                : mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 255, 176),
                border: Border.all(color: Colors.lightGreen),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: widget.message.type == Type.text
                ?
                //show text
                Text(
                    widget.message.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :
                //show image
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.message.msg,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  //dialog for updating message content
}
