import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild(
      {super.key,
      required this.textFeildController,
      required this.title,
      this.prefixText});

  final TextEditingController textFeildController;
  final String title;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 16),
      maxLength: 50,
      controller: textFeildController,
      decoration: InputDecoration(
        prefixText: prefixText,
        label: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
