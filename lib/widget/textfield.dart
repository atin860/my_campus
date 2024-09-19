import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.label, required this.hintText});
  final String label;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        decoration: InputDecoration(
            label: Text(label),
            hintText: hintText,
            // "biet14@gmail.com",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
