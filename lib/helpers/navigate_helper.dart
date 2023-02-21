import 'package:flutter/material.dart';

class NavigateHelper {
  void navigator(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}
