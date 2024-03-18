// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class MyApi extends StatefulWidget {
//   const MyApi({super.key});

//   @override
//   State<MyApi> createState() => _MyApiState();
// }

// late Map mapresp = {};
// late List listresp = [];

// class _MyApiState extends State<MyApi> {
//   @override
//   void initState() {
//     apicall();

//     // TODO: implement initState
//     super.initState();
//   }

//   Future<void> apicall() async {
//     http.Response response =
//         await http.get(Uri.parse("https://reqres.in/api/users?page=2"));

//     if (response.statusCode == 200) {
//       setState(() {
//         // responsedata = response.body;

//         mapresp = jsonDecode(response.body);
//         listresp = mapresp["data"];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemBuilder: (context, index) {
//           return ListTile(
//             // leading: mapresp["data"][index]["email"],
//             title: Text(listresp[index]["email"]),
//           );
//         },
//         itemCount: listresp.length,
//       ),
//     );
//   }
// }
