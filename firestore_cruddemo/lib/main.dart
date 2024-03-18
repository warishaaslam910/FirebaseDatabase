import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_cruddemo/Home.dart';
import 'package:firestore_cruddemo/Surah.dart';
import 'package:firestore_cruddemo/firebase_options.dart';
import 'package:flutter/material.dart';

import 'MyApi.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Surah(),
    );
  }
}
