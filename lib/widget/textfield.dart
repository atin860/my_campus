import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.label,
      required this.hintText,
      this.controller});
  final String label;
  final String hintText;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            label: Text(label),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            // "biet14@gmail.com",
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
