import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const MainButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      onPressed: onPressed,
      color: Colors.amber,
      elevation: 0,
      child: Text(
        title,
      ),
    );
  }
}
