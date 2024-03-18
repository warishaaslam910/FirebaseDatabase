// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// int id = 0;
// var titlecontroller = TextEditingController();
// var desccontroller = TextEditingController();

// final dbcoll = FirebaseFirestore.instance.collection("Appusers");
// final getdata = FirebaseFirestore.instance
//     .collection("Appusers")
//     .doc(key)
//     .collection("userposts")
//     .snapshots();

// final key = FirebaseAuth.instance.currentUser!.uid;
// ////SHOW MODEL
// showformodel(context, int? postid) async {
//   showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.fromLTRB(
//               32, 32, 32, MediaQuery.of(context).viewInsets.bottom),
//           child: Column(
//             children: [
//               TextField(
//                 controller: titlecontroller,
//                 decoration: InputDecoration(hintText: "ENTER TITLE"),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextField(
//                 controller: desccontroller,
//                 decoration: InputDecoration(hintText: "ENTER DESC"),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     if (postid == null) {
//                       id++;
//                       dbcoll.doc(key).collection("userposts").doc("$id").set({
//                         "id": id,
//                         "Title": titlecontroller.text,
//                         "Description": desccontroller.text,
//                         "Dateofpost": DateTime.now().toString()
//                       }).then((value) {
//                         print("successfully uploaded");
//                       }).onError((error, stackTrace) {
//                         print("error, ${error}");
//                       });
//                     } else {
//                       dbcoll
//                           .doc(key)
//                           .collection("Userspost")
//                           .doc("$postid")
//                           .update({
//                         "id": id,
//                         "Title": titlecontroller.text,
//                         "Description": desccontroller.text,
//                         "Dateofpost": DateTime.now().toString()
//                       });
//                     }
//                   },
//                   child: Text("SUBMIT")),
//               SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         );
//       });
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("CRUD"),
//         leading: ElevatedButton(
//             onPressed: () {
//               showformodel(context, null);
//             },
//             child: Text("ADD")),
//       ),
//       body: Expanded(
//         child: StreamBuilder(
//           stream: getdata,
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else {
//               // Handle snapshot data here
//               return ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   final items = snapshot.data!.docs[index];
//                   return ListTile(
//                     title: Text(items["title"].toString()),
//                     subtitle: Text(items['Description'].toString()),
//                     trailing: PopupMenuButton(
//                       icon: Icon(Icons.menu),
//                       itemBuilder: (context) {
//                         return [
//                           PopupMenuItem(
//                             value: 1,
//                             child: ListTile(
//                               onTap: () {
//                                 final id = items['id'].toString();
//                                 dbcoll
//                                     .doc(key)
//                                     .collection("Userspost")
//                                     .doc(id)
//                                     .delete();
//                                 Navigator.pop(context);
//                               },
//                               leading: Icon(Icons.delete),
//                               title: Text("Delete"),
//                             ),
//                           ),
//                           PopupMenuItem(
//                             value: 2,
//                             child: ListTile(
//                               onTap: () {
//                                 final id = items['id'].toString();
//                                 showformodel(context, int.parse(id));
//                               },
//                               leading: Icon(Icons.edit),
//                               title: Text("edit"),
//                             ),
//                           )
//                         ];
//                       },
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
