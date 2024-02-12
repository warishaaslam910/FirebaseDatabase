// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dbfirebaseproj_3chatapp/models/Chatuser.dart';
// import 'package:dbfirebaseproj_3chatapp/models/Message.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('Body: ${message.notification?.body}');
//   print('payload: ${message.data}');
// }

// class APIs {
//   static FirebaseAuth auth = FirebaseAuth.instance;
//   static FirebaseFirestore firestore = FirebaseFirestore.instance;
//   static FirebaseStorage storage = FirebaseStorage.instance;
//   static User get user => auth.currentUser!;
//   static Chatuser me = Chatuser(
//       image: '',
//       about: "Hey I'm using My Book!",
//       name: user.displayName.toString(),
//       createdAt: '',
//       id: user.uid,
//       isOnline: false,
//       email: user.email.toString(),
//       pushToken: '',
//       lastactive: '');
//   static FirebaseMessaging fmessaging = FirebaseMessaging.instance;
//   static Future<void> getFirebaseMessagingToken() async {
//     FirebaseMessaging.instance.setAutoInitEnabled(true);
//     await fmessaging.requestPermission();
//     await fmessaging.getToken().then((t) {
//       if (t != null) {
//         me.pushToken = t;
//         print('push token:$t');
//         FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//       }
//     });
//   }

// //check user exist or not
//   static Future<bool> userExists() async {
//     return (await firestore.collection('users').doc(user.uid).get()).exists;
//   }

//   static Future<void> getselfinfo() async {
//     await firestore.collection('users').doc(user.uid).get().then(((user) async {
//       if (user.exists) {
//         me = Chatuser.fromJson(user.data()!);
//         await getFirebaseMessagingToken();
//         //for setting user status to active
//         APIs.UpdateActiveStatus(true);
//         print('My Data: ${user.data()}');
//       } else {
//         await createUser().then((value) => getselfinfo());
//       }
//     }));
//   }

//   //creating new user
//   static Future<void> createUser() async {
//     final time = DateTime.now().millisecondsSinceEpoch.toString();
//     final chatUser = Chatuser(
//       id: user.uid,
//       name: user.displayName.toString(),
//       email: user.email.toString(),
//       about: "Hey there, I am using MyBook",
//       image: user.photoURL.toString(),
//       createdAt: time,
//       isOnline: false,
//       lastactive: time,
//       pushToken: '',
//     );

//     return await firestore
//         .collection('users')
//         .doc(user.uid)
//         .set(chatUser.toJson());
//   }

//   ///get all users from firestore database
//   Stream<QuerySnapshot<Map<String, dynamic>>> getallusers() {
//     return firestore
//         .collection('users')
//         .where('id', isNotEqualTo: user.uid)
//         .snapshots();
//   }

// //for updatig user information
//   static Future<void> updateuserinfo() async {
//     await firestore.collection('users').doc(user.uid).update({
//       'name': me.name,
//       'about': me.about,
//     });
//   }

// //update profile picture of user
//   static Future<void> updateprofilepicture(File file) async {
//     final ext = file.path.split('.').last;
//     print('Extension : $ext');
//     final ref = storage.ref().child('profile_picture/${user.uid}.$ext');
//     await ref
//         .putFile(file, SettableMetadata(contentType: 'image/$ext'))
//         .then((p0) {
//       print('Data is transfered: ${p0.bytesTransferred / 1000}kb');
//     });
//     me.image = await ref.getDownloadURL();
//     await firestore
//         .collection('users')
//         .doc(user.uid)
//         .update({'image': me.image});
//   }

// //for getting specific user info
//   static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
//       Chatuser chatuser) {
//     return firestore
//         .collection('users')
//         .where('id', isEqualTo: chatuser.id)
//         .snapshots();
//   }

// //update online or last active status of user
//   static Future<void> UpdateActiveStatus(bool isOnline) async {
//     firestore.collection('users').doc(user.uid).update({
//       'is_online': isOnline,
//       'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
//       'push_token': me.pushToken,
//     });
//   }

// //////////////////// Chat screen APIS/////////

//   static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
//       ? '${user.uid}_$id'
//       : '${id}_${user.uid}';

//   /// for getting all users from firestore database ////
//   Stream<QuerySnapshot<Map<String, dynamic>>> getallmessages(Chatuser user) {
//     return firestore
//         .collection('chats/${getConversationID(user.id)}/messages/')
//         .orderBy('sent', descending: true)
//         .snapshots();
//   }

//   //chats(coll)-->conversation id(doc)-->messages(coll)-->message(doc)
// //for sending msgs
//   static Future<void> sendMessage(
//       Chatuser chatUser, String msg, Type type) async {
//     final time = DateTime.now().millisecondsSinceEpoch.toString();
//     //message to send
//     final Messages message = Messages(
//         toid: chatUser.id,
//         msg: msg,
//         read: '',
//         type: type,
//         sent: time,
//         fromid: user.uid);

//     final ref = firestore
//         .collection('chats/${getConversationID(chatUser.id)}/messages/');
//     await ref.doc(time).set(message.toJson());
//   }

//   //update read status of msg
//   static Future<void> updateMessageReadStatus(Messages message) async {
//     firestore
//         .collection('chats/${getConversationID(message.fromid)}/messages/')
//         .doc(message.sent)
//         .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
//   }

// //get only last msg of a specific chat
//   static Stream<QuerySnapshot> getLastMessage(Chatuser user) {
//     return firestore
//         .collection('chats/${getConversationID(user.id)}/messages/')
//         .orderBy('sent', descending: true)
//         .limit(1)
//         .snapshots();
//   }

// //send chat image
//   static Future<void> sendChatImage(Chatuser chatuser, File file) async {
//     final ext = file.path.split('.').last;

//     final ref = storage.ref().child(
//         'images/${getConversationID(chatuser.id)}/${DateTime.now().millisecondsSinceEpoch}');
//     await ref
//         .putFile(file, SettableMetadata(contentType: 'image/$ext'))
//         .then((p0) {
//       print('Data is transfered: ${p0.bytesTransferred / 1000}kb');
//     });
//     final imageUrl = await ref.getDownloadURL();
//     await sendMessage(chatuser, imageUrl, Type.image);
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';

import 'package:dbfirebaseproj_3chatapp/models/Chatuser.dart';
import '../models/message.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  // for storing self information
  static Chatuser me = Chatuser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "Hey, I'm using We Chat!",
      image: user.photoURL.toString(),
      createdAt: '',
      isOnline: false,
      lastactive: '',
      pushToken: '');

  // to return current user
  static User get user => auth.currentUser!;

  // for accessing firebase messaging (Push Notification)
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  // for getting firebase messaging token
  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;
        log('Push Token: $t');
      }
    });

    // for handling foreground messages
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   log('Got a message whilst in the foreground!');
    //   log('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     log('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }

  // for sending push notification
  static Future<void> sendPushNotification(
      Chatuser chatUser, String msg) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": me.name, //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
        // "data": {
        //   "some_data": "User ID: ${me.id}",
        // },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAAQ0Bf7ZA:APA91bGd5IN5v43yedFDo86WiSuyTERjmlr4tyekbw_YW6JrdLFblZcbHdgjDmogWLJ7VD65KGgVbETS0Px7LnKk8NdAz4Z-AsHRp9WoVfArA5cNpfMKcjh_MQI-z96XQk5oIDUwx8D1'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

  // for checking if user exists or not?
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // for adding an chat user for our conversation
  static Future<bool> addChatUser(String email) async {
    final data = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    log('data: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      //user exists

      log('user exists: ${data.docs.first.data()}');

      firestore
          .collection('users')
          .doc(user.uid)
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      //user doesn't exists

      return false;
    }
  }

  // for getting current user info
  static Future<void> getselfinfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = Chatuser.fromJson(user.data()!);
        await getFirebaseMessagingToken();

        //for setting user status to active
        APIs.UpdateActiveStatus(true);
        log('My Data: ${user.data()}');
      } else {
        await createUser().then((value) => getselfinfo());
      }
    });
  }

  // for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = Chatuser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey, I'm using We Chat!",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastactive: time,
        pushToken: '');

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  // for getting id's of known users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('my_users')
        .snapshots();
  }

  // for getting all users from firestore database

  static Stream<QuerySnapshot<Map<String, dynamic>>> getallusers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  // for adding an user to my user when first message is send
  static Future<void> sendFirstMessage(
      Chatuser chatUser, String msg, Type type) async {
    await firestore
        .collection('users')
        .doc(chatUser.id)
        .collection('my_users')
        .doc(user.uid)
        .set({}).then((value) => sendMessage(chatUser, msg, type));
  }

  // for updating user information
  static Future<void> updateuserinfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  // update profile picture of user
  static Future<void> updateprofilepicture(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    log('Extension: $ext');

    //storage file ref with path
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me.image});
  }

  // for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getuserinfo(
      Chatuser chatUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  // update online or last active status of user
  static Future<void> UpdateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  ///************** Chat Screen Related APIs **************

  // chats (collection) --> conversation_id (doc) --> messages (collection) --> message (doc)

  // useful for getting conversation id
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  // for getting all messages of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      Chatuser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  // for sending message
  // static Future<void> sendMessage(
  //     Chatuser chatUser, String msg, Type type) async {
  //   //message sending time (also used as id)
  //   final time = DateTime.now().millisecondsSinceEpoch.toString();

  //   //message to send
  //   final Messages message = Messages(
  //       toid: chatUser.id,
  //       msg: msg,
  //       read: '',
  //       type: type,
  //       sent: time,
  //       fromid: user.uid,
  //       imageUrl: '');

  //   final ref = firestore
  //       .collection('chats/${getConversationID(chatUser.id)}/messages/');
  //   await ref.doc(time).set(message.toJson()).then((value) =>
  //       sendPushNotification(chatUser, type == Type.text ? msg : 'image'));
  // }

  static Future<void> sendMessage(
      Chatuser chatUser, String msg, Type type) async {
    // Message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    // Message to send
    final Messages message = Messages(
        toid: chatUser.id,
        msg: type == Type.image ? msg : '', // Empty message for non-image types
        imageUrl:
            type == Type.image ? msg : '', // Store image URL for image types
        read: '',
        type: type,
        sent: time,
        fromid: user.uid);

    try {
      final ref = firestore
          .collection('chats/${getConversationID(chatUser.id)}/messages/');
      await ref.doc(time).set(message.toJson());

      // Send push notification
      await sendPushNotification(chatUser, type == Type.text ? msg : 'image');
    } catch (e) {
      // Handle any errors
      log('Error sending message: $e');
    }
  }

  //update read status of message
  static Future<void> updatemessagereadstatus(Messages message) async {
    firestore
        .collection('chats/${getConversationID(message.fromid)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      Chatuser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //send chat image
  static Future<void> sendChatImage(Chatuser chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage.ref().child(
        'images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }

  //delete message
}
