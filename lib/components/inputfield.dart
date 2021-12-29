import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function validator;
  final TextInputType textInputType;

  InputField({
    this.controller,
    this.label,
    this.validator,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(),
          ),
          keyboardType: textInputType,
          validator: validator,
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
