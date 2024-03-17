import 'package:flutter/material.dart';

class EnterNewHabit extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const EnterNewHabit(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          color: Colors.white,
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.black),
          ),
        ),
        MaterialButton(
          onPressed: onCancel,
          color: Colors.white,
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
