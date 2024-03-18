// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCPEqTYsw_p_F3WMlveg9IjgdhW7cS-o0I',
    appId: '1:223550122840:web:653cc0eae61e6804ee532d',
    messagingSenderId: '223550122840',
    projectId: 'demofirestorecrud-8b869',
    authDomain: 'demofirestorecrud-8b869.firebaseapp.com',
    storageBucket: 'demofirestorecrud-8b869.appspot.com',
    measurementId: 'G-PN0SLC1FME',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDscqhpeloQvjBA4rXOs0tEHZqZDZIMZcU',
    appId: '1:223550122840:android:4fe2e89c74288d68ee532d',
    messagingSenderId: '223550122840',
    projectId: 'demofirestorecrud-8b869',
    storageBucket: 'demofirestorecrud-8b869.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDeUSqFIlF4sLbFJm2ifKx3z6s6359RLnM',
    appId: '1:223550122840:ios:f26f125f50f5c22cee532d',
    messagingSenderId: '223550122840',
    projectId: 'demofirestorecrud-8b869',
    storageBucket: 'demofirestorecrud-8b869.appspot.com',
    iosBundleId: 'com.example.firestoreCruddemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDeUSqFIlF4sLbFJm2ifKx3z6s6359RLnM',
    appId: '1:223550122840:ios:b8d2fff344d5d5e4ee532d',
    messagingSenderId: '223550122840',
    projectId: 'demofirestorecrud-8b869',
    storageBucket: 'demofirestorecrud-8b869.appspot.com',
    iosBundleId: 'com.example.firestoreCruddemo.RunnerTests',
  );
}