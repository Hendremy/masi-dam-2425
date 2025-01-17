import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText, hintText;
  final Key? key;
  final bool active;
  final IconData? icon;
  final bool obscureText;
  final TextInputType type;
  final ValueChanged<String>? action;
  final String? errorText;

  const CustomInputField({
    this.controller,
    required this.labelText,
    required this.hintText,
    this.active = true,
    required this.icon,
    this.obscureText = false,
    required this.type,
    this.key,
    this.action, 
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: type,
      onChanged: action,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(this.icon, color: Color(0xFF00BCD4)),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        errorText: errorText,
        errorStyle: TextStyle(fontSize: 10)
      ),
      enabled: active,
    );
  }
}
