import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class localnotificationservice {
  localnotificationservice();
  final _localnotificationservice = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings=
    = AndroidInitializationSettings("");

    
  }
}
