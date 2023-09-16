import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Toast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int id = 0;
var titleController = TextEditingController();
var descController = TextEditingController();
var searchCont = TextEditingController();
//DatabaseReference dbref=FirebaseDatabase.instance.ref('users');
final dbcoll = FirebaseFirestore.instance.collection("AppUsers");
final key = FirebaseAuth.instance.currentUser!.uid;
final getdata = FirebaseFirestore.instance
    .collection("AppUsers")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection("Userspost")
    .snapshots();
showformmodel(context, int? postid) async {
  titleController.clear();
  descController.clear();

  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
            padding: EdgeInsets.fromLTRB(
                32, 32, 32, MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: "Enter Your Title "),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: descController,
                  decoration:
                      InputDecoration(hintText: "Enter Your Description"),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (postid == null) {
                        id++;
                        dbcoll.doc(key).collection("Userspost").doc("$id").set({
                          "Id": id,
                          "Title": titleController.text,
                          "Description": descController.text,
                          "Dateofpost": DateTime.now().toString()
                        }).then((value) {
                          Toast().toastmsg("Successfully Uploaded");
                        }).onError((error, stackTrace) {
                          Toast().toastmsg("$error");
                        });
                      } else {
                        dbcoll
                            .doc(key)
                            .collection("Userspost")
                            .doc("$postid")
                            .update({
                          "Id": postid,
                          "Title": titleController.text,
                          "Description": descController.text,
                          "Dateofpost": DateTime.now().toString()
                        }).then((value) {
                          Toast().toastmsg("Successfully Updated");
                        }).onError((error, stackTrace) {
                          Toast().toastmsg("$error");
                        });
                      }
                      Navigator.pop(context);
                    },
                    child: postid == null ? Text("Submit") : Text("Update")),
                SizedBox(
                  height: 20,
                ),
              ],
            ));
      });
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  showformmodel(context, null);
                },
                child: Text("ADD"))),

        /////////////// UI /////////////////////////
        ///
        Expanded(
            child: StreamBuilder(
                stream: getdata,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.docs[index];
                          return ListTile(
                            title: Text(data["Title"].toString()),
                            subtitle: Text(data['Description'].toString()),
                            trailing: PopupMenuButton(
                                icon: Icon(Icons.menu_sharp),
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: 1,
                                      child: ListTile(
                                        onTap: () {
                                          final id = data['Id'].toString();
                                          showformmodel(context, int.parse(id));
                                        },
                                        leading: Icon(Icons.edit),
                                        title: Text("Edit"),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: ListTile(
                                        onTap: () {
                                          final id = data['Id'].toString();
                                          // dref.child(key).child(id).remove();

                                          dbcoll
                                              .doc(key)
                                              .collection("Userspost")
                                              .doc(id)
                                              .delete();

                                          Navigator.pop(context);
                                        },
                                        leading: Icon(Icons.delete),
                                        title: Text("Delete"),
                                      ),
                                    ),
                                  ];
                                }),
                          );
                        });
                  }
                }))
      ])),
    );
  }
}
