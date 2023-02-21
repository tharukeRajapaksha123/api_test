// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final bool shouldObscure;
  final String hintText;
  final bool shouldValidate;
  const InputField({
    Key? key,
    required this.controller,
    this.shouldObscure = false,
    required this.hintText,
    this.shouldValidate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: shouldObscure,
      validator: shouldValidate
          ? (val) => val != null
              ? val.isEmpty
                  ? "Please fill this field"
                  : null
              : null
          : null,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
