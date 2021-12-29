import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("h:mm a");
  final String label;
  final Function validator;
  final TextEditingController controller;

  BasicTimeField({this.label, this.validator, this.controller});

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      decoration: InputDecoration(
        labelText: label
      ),
      format: format,
      validator: validator,
      controller: controller,
      onShowPicker: (context, currentValue) async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
        );
        return DateTimeField.convert(time);
      },
    );
  }
}
