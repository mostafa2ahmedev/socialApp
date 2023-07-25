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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        style: const TextStyle(color: Colors.blueGrey),
        controller: controller,
        keyboardType: TextInputType.name,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          fillColor: Colors.grey[200],
          filled: true,
          label: Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
          ),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedErrorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: Icon(iconData),
        ),
      ),
    );
  }
}
