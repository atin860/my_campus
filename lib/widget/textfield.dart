import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.onTap,
  });
  final String label;
  final String hintText;
  // final String keyboardType;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            filled: true,
            label: Text(label),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            // "biet14@gmail.com",
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(10))),
        onTap: onTap,
      ),
    );
  }
}

class DateOfBirthField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;

  const DateOfBirthField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
  });

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                filled: true,
                labelText: label,
                hintText: hintText,
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
      ),
    );
  }
}
