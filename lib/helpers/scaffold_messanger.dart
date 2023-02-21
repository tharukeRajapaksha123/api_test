import 'package:flutter/material.dart';

class ScaffoldMessangerCustom {
  void scaffoldMessage(String message, BuildContext context) {
    final SnackBar snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
