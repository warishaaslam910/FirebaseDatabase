import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbfirebaseproj_3chatapp/models/Chatuser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;
  static Chatuser me = Chatuser(
      image: '',
      about: "Hey I'm using My Book!",
      name: user.displayName.toString(),
      createdAt: '',
      id: user.uid,
      isOnline: false,
      email: user.email.toString(),
      pushToken: '',
      lastactive: '');

//check user exist or not
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> getselfinfo() async {
    await firestore.collection('users').doc(user.uid).get().then(((user) async {
      if (user.exists) {
        me = Chatuser.fromJson(user.data()!);
        print('My Data: ${user.data()}');
      } else {
        await createUser().then((value) => getselfinfo());
      }
    }));
  }

  //creating new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = Chatuser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "Hey there, I am using MyBook",
      image: user.photoURL.toString(),
      createdAt: time,
      isOnline: false,
      lastactive: time,
      pushToken: '',
    );

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  ///get all users from firestore database
  Stream<QuerySnapshot<Map<String, dynamic>>> getallusers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  static Future<void> updateuserinfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }
}
