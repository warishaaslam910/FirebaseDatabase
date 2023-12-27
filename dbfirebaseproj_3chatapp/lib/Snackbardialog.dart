import 'dart:ffi';

import 'package:flutter/material.dart';

class Snackbardialog {
  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Color.fromARGB(255, 32, 124, 199),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static void showprogbar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Center(child: CircularProgressIndicator()));
  }
}
