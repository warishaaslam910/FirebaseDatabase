import 'package:db_proj_blogappui/pages/Splash.dart';
import 'package:db_proj_blogappui/pages/UserBlogpage.dart';
import 'package:flutter/material.dart';

import 'pages/AddBlogpage.dart';
import 'pages/Homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AddBlogpage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
