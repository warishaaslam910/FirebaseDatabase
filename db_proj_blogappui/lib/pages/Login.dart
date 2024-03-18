import 'package:db_proj_blogappui/pages/Homepage.dart';
import 'package:db_proj_blogappui/pages/Signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final dbref = FirebaseDatabase.instance.ref("testusers");
  //final key = FirebaseAuth.instance.currentUser!.uid;
  final key = FirebaseAuth.instance.currentUser?.uid ?? 'default_value';

  bool ishidden = true;
  var loginemail = TextEditingController();
  var loginpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                    const Color.fromARGB(255, 252, 78, 78),
                    Color.fromARGB(255, 238, 168, 168),
                  ])),
              child: Padding(
                padding: EdgeInsets.only(top: 80, right: 42),
                child: Text(' Login ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              )),
          Padding(
            padding: EdgeInsets.only(top: 200),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 18, right: 18, top: 85),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: loginemail,
                        decoration: InputDecoration(
                            label: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 18,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.black.withOpacity(0.4),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.redAccent))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: ishidden,
                        controller: loginpassword,
                        decoration: InputDecoration(
                          label: Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                              fontSize: 18,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                ishidden = !ishidden;
                              });
                            },
                            icon: Icon(
                              ishidden == true
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 70,
                            ),
                            Text('Create an account ',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.75),
                                    fontSize: 15)),
                            InkWell(
                              child: Text('  Signup',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup()));
                              },
                            ),
                          ],
                        ),
                      ),

                      //////////////////////login btn ///////////////
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              const Color.fromARGB(255, 252, 78, 78),
                              Color.fromARGB(255, 238, 168, 168),
                            ])),
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: loginemail.text,
                                  password: loginpassword.text,
                                )
                                    .then((value) {
                                  Navigator.push(
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
                                              )));
                                });
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
