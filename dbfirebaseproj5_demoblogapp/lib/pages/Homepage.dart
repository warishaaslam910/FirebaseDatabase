import 'package:db_proj_blogappui/widgets/Blogwidget.dart';
import 'package:db_proj_blogappui/widgets/Categorieswidget.dart';
import 'package:db_proj_blogappui/widgets/Homeappbar.dart';
import 'package:db_proj_blogappui/widgets/Sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  final String blogID;
  final String blogTitle;
  final String blogDescription;
  final String ind;
  final DatabaseReference dbref;

  Homepage(
      {Key? key,
      required this.blogID,
      required this.blogTitle,
      required this.blogDescription,
      required this.ind,
      required this.dbref})
      : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final dbref = FirebaseDatabase.instance.ref("testusers");
  // final key = FirebaseAuth.instance.currentUser!.uid;
  final key = FirebaseAuth.instance.currentUser?.uid ?? 'default_value';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      body: ListView(
        children: [
          Homeappbar(),

          //////main container
          Container(
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //search bar
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          height: 50,
                          // width: 300,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search here.....",
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.search,
                          size: 27,
                          color: const Color.fromARGB(255, 31, 30, 30)),
                    ],
                  ),
                ),
                /////////////CATEGORIES//////////////
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                //////////////////////categories widget//////////
                Categorieswidget(),
                /////////// Blogs/////////////
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: MediaQuery.of(context)
                      .size
                      .height, // Set a specific height
                  child: Blogwidget(
                    blogID: '',
                    blogTitle: '',
                    blogDescription: '',
                    ind: '',
                    dbref: dbref,
                  ),
                ),
              ],
            ), //main column
          ) //main container
        ],
      ),
    );
  }
}
