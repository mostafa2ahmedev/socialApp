import 'package:flutter/material.dart';

class TextFieldProfile extends StatelessWidget {
  const TextFieldProfile(
      {super.key,
      required this.controller,
      this.validator,
      required this.iconData,
      required this.label});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData iconData;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      validator: validator,
      decoration: InputDecoration(
        label: Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
        prefixIcon: Icon(iconData),
      ),
    );
  }
}
