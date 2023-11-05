import 'dart:async';
import 'dart:io';

import 'package:dbfirebaseproj2_images/Myimages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    final User = auth.currentUser;


    if (User != null) {
      Timer(Duration(seconds: 3), (() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Myimages()));
      }));
    } else {
      Timer(Duration(seconds: 3), (() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Text("ABC")],
        ),
      ),
    );
  }
}
