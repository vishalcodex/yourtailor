import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  final String label;
  final Function validator;
  final TextEditingController controller;

  BasicDateField({this.label, this.validator, this.controller});

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      format: format,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: validator,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime.now().add(Duration(days: 1)),
            initialDate: currentValue ?? DateTime.now().add(Duration(days: 1)),
            lastDate: DateTime(2100));
      },
    );
  }
}
