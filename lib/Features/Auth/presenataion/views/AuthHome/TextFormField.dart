import 'package:flutter/material.dart';

class TextFormFieldAuth extends StatelessWidget {
  const TextFormFieldAuth({
    super.key,
    this.onSaved,
    required this.hinttext,
    required this.preicon,
    this.suficon,
    required this.validator,
    required this.controller,
    this.ontap,
    this.obscureText = false,
    required this.keyboardType,
    required this.label,
  });

  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String hinttext;
  final IconData preicon;
  final IconData? suficon;
  final TextEditingController controller;
  final VoidCallback? ontap;
  final bool obscureText;
  final TextInputType keyboardType;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        label: Text(label),
        hintText: hinttext,
        prefixIcon: Icon(preicon),
        suffixIcon: GestureDetector(onTap: ontap, child: Icon(suficon)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.red)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
