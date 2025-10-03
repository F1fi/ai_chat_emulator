import 'package:flutter/material.dart';

class ChatField extends StatelessWidget {
  const ChatField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Type something...',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0),
          borderRadius: BorderRadius.all(Radius.circular(24)),
          gapPadding: 0,
        ),
        contentPadding: EdgeInsets.all(16),
        isDense: true,
      ),
    );
  }
}
