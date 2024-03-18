import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';

class Blogpage extends StatefulWidget {
  final String blogID;
  final String? blogTitle;
  final String? blogDescription;
  final String? ind;
  final DatabaseReference dbref;
  final String? imageurl;

  Blogpage({
    Key? key,
    required this.blogID,
    required this.ind,
    required this.dbref,
    this.blogTitle,
    this.blogDescription,
    this.imageurl,
  }) : super(key: key);

  @override
  State<Blogpage> createState() => _BlogpageState();
}

class _BlogpageState extends State<Blogpage> {
  final dbref = FirebaseDatabase.instance.ref("testusers");
  final key = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String dateStr = "${today.day}/${today.month}/${today.year}";

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFEDECF2),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: "blogImage",
                  child: widget.imageurl != null
                      ? Image.network(
                          widget.imageurl!,
                          height: 350.0,
                          width: size.width,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 64,
                    bottom: 0.0,
                    left: 24,
                    right: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homepage(
                                blogID: '',
                                blogTitle: '',
                                blogDescription: '',
                                ind: '',
                                dbref: dbref,
                                imageurl: '',
                                likescount: 0,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(48.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: size.width / 2,
                        child: Text(
                          widget.blogTitle ?? "",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: 34,
                        width: 98,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "$dateStr",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Mulish-SemiBold",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Colors.black.withOpacity(0.08),
                    height: 32.0,
                  ),
                  Text(
                    widget.blogDescription ?? "",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: "Mulish-SemiBold",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
