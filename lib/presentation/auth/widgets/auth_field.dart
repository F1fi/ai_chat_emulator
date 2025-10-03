import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.isTextHideable = false,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isTextHideable;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isObscured = false;

  @override
  void initState() {
    super.initState();
    if (widget.isTextHideable) isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscured,
      validator: widget.validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text(widget.label),
        suffixIcon:
            widget.isTextHideable
                ? InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    setState(() => isObscured = !isObscured);
                  },
                  child: Icon(
                    isObscured ? Icons.lock : Icons.remove_red_eye,
                    size: 24,
                  ),
                )
                : null,
        contentPadding: EdgeInsets.all(16),
        isDense: true,
      ),
    );
  }
}
