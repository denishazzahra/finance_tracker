import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../utils/custom_converter.dart';
import 'custom_text_field.dart';

class CustomDatePicker {
  static void _selectDate({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    required Rx<DateTime> dateTime,
    required TextEditingController controller,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      dateTime.value = pickedDate;
      controller.text = CustomConverter.dateToStr(pickedDate);
    }
  }

  static TextField datePicker(
    TextEditingController controller, {
    required BuildContext context,
    required Rx<DateTime> dateTime,
  }) {
    DateTime today = DateTime.now();
    DateTime firstDate = DateTime(today.year - 1, today.month, today.day);
    return CustomTextField.normal(
      controller,
      context: context,
      isReadOnly: true,
      label:"Date (optional)",
      suffixIcon: GestureDetector(
        onTap: () => _selectDate(
          context: context,
          initialDate: dateTime.value,
          firstDate: firstDate,
          lastDate: today,
          dateTime: dateTime,
          controller: controller,
        ),
        child: Icon(Symbols.calendar_month, size: 24),
      ),
    );
  }
}
