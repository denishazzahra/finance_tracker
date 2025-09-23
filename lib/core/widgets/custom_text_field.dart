import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField {
  static TextField normal(
    TextEditingController controller, {
    String? label,
    Color? textColor,
    bool isObscure = false,
    bool isReadOnly = false,
    bool isNumOnly = false,
    bool isLabelInvisible = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Function? onChanged,
    required BuildContext context,
    int maxlines = 1,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      readOnly: isReadOnly,
      keyboardType: isNumOnly ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumOnly
          ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))]
          : null,
      style: TextStyle(
        color: textColor ?? Theme.of(context).colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: isLabelInvisible ? null : label,
        hintText: isLabelInvisible ? label : null,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
        ),
      ),
      maxLines: maxlines,
      onChanged: (value) {
        if (onChanged != null) onChanged(value);
      },
    );
  }

  static TextField auth(
    TextEditingController controller, {
    required String label,
    Color? textColor,
    bool isObscure = false,
    bool isReadOnly = false,
    bool isNumOnly = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    required BuildContext context,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: TextStyle(
        color: textColor ?? Theme.of(context).colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        hintText: label,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
        ),
      ),
    );
  }
}
