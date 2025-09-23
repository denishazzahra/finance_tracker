import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CustomButton {
  static IconButton icon(
    IconData icon, {
    required BuildContext context,
    required Function onPressed,
    bool isSmall = false,
    Color? color,
  }) {
    return IconButton(
      onPressed: () => onPressed(),
      icon: Icon(icon, size: isSmall ? 12 : 24),
      visualDensity: VisualDensity.compact,
      color: color ?? Theme.of(context).primaryColor,
    );
  }

  static dropdown({
    required dynamic selectedItem,
    required List<dynamic> items,
    required Function onChanged,
    required BuildContext context,
  }) {
    return DropdownButton(
      value: selectedItem,
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item.name,
              alignment: AlignmentGeometry.center,
              child: Icon(
                item.icon,
                color: Theme.of(context).primaryColor,
                fill: item.name == selectedItem ? 1 : 0,
              ),
            ),
          )
          .toList(),
      onChanged: (val) => onChanged(val),
      isDense: true,
      underline: SizedBox.shrink(),
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      focusColor: Colors.transparent,
      icon: Icon(Symbols.keyboard_arrow_down),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
