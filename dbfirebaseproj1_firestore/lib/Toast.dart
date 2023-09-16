import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  void toastmsg(msg) async {
    Fluttertoast.showToast(
      msg: msg,
      //toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 6, 6, 190),
      textColor: Colors.red,
      fontSize: 16.0,
    );
  }
}
