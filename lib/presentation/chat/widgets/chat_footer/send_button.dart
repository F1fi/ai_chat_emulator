import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      child: IconButton(
        color: Colors.white,
        onPressed: onPressed,
        icon: Icon(Icons.send),
      ),
    );
  }
}
