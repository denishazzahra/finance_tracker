import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CustomDropdown {
  static DropdownButtonFormField<dynamic> obj(
    String hint,
    dynamic val,
    List<dynamic> items,
    Function onChanged, {
    IconData? icon,
  }) {
    return DropdownButtonFormField<dynamic>(
      initialValue: val,
      items: <DropdownMenuItem<dynamic>>[
        for (dynamic item in items)
          DropdownMenuItem(value: item, child: Text(item.name)),
      ],
      onChanged: (value) {
        onChanged(value);
      },
      // isExpanded: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: hint,
      ),
      icon: Icon(icon ?? Symbols.keyboard_arrow_down),
    );
  }

  static DropdownButtonFormField<String> str(
    String hint,
    String? val,
    List<String> items,
    Function onChanged, {
    bool discardFirstItem = false,
    IconData? icon,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: val,
      items: <DropdownMenuItem<String>>[
        for (String item in items)
          DropdownMenuItem(value: item, child: Text(item)),
      ],
      onChanged: (value) {
        if (discardFirstItem && value == items[0]) {
          onChanged(null);
        } else {
          onChanged(value);
        }
      },
      // isExpanded: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: hint,
      ),
      icon: Icon(icon ?? Symbols.keyboard_arrow_down),
    );
  }
}
