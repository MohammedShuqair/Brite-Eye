import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/app_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {super.key,
      required this.controller,
      required this.label,
      this.validator,
      this.textInputAction = TextInputAction.next});

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  void toggleObscure() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppField(
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      label: widget.label,
      validator: widget.validator,
      obscureText: obscureText,
      suffixIcon: GestureDetector(
        onTap: toggleObscure,
        child: UnconstrainedBox(
            child: obscureText
                ? const Icon(Icons.visibility, size: 20)
                : const Icon(Icons.visibility_off, size: 20)),
      ),
    );
  }
}
