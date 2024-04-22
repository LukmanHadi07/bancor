import 'package:flutter/material.dart';
import 'package:tambalbanonline/app/utils/commont/colors.dart';

class CustomTextFieldViews extends StatelessWidget {
  final String title;
  final String? label;
  final TextEditingController controller;

  const CustomTextFieldViews({
    super.key,
    required this.title,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: controller,
        enabled: false,
        decoration: InputDecoration(
            labelText: label == "" ? "empty" : label ?? "empty",
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorsApp.orange, width: 2.0),
          ),
            hintText: title,
            hintStyle: const TextStyle(color: Colors.black87),
            ),
            
      ),
    );
  }
}
