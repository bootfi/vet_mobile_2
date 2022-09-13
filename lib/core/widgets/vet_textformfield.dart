import 'package:flutter/material.dart';
import '/core/core.dart';

class VetTextFormField extends StatelessWidget {
  const VetTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
  }) : super(key: key);
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: context.textTheme.bodySmall,
        errorStyle: const TextStyle(height: 1),
        contentPadding: const EdgeInsetsDirectional.fromSTEB(13, 12, 0, 12),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0XFFcdcdcd))),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red[600]!,
          ),
        ),
      ),
    );
  }
}
