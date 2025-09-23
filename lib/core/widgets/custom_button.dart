import 'package:finance_tracker/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:material_symbols_icons/symbols.dart';

class CustomButton {
  static ElevatedButton primary(
    String text, {
    IconData? icon,
    required BuildContext context,
    Function? onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed != null
          ? () {
              onPressed();
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        padding: const EdgeInsets.all(16),
      ),
      child: icon == null
          ? CustomText.normal(
              text,
              context: context,
              isBold: true,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fill: 1,
                ),
                CustomText.normal(
                  text,
                  context: context,
                  isBold: true,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ],
            ),
    );
  }

  static TextButton text(
    String text, {
    required BuildContext context,
    Function? onPressed,
    Color? color,
  }) {
    return TextButton(
      onPressed: onPressed != null
          ? () {
              onPressed();
            }
          : null,
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: color ?? Theme.of(context).colorScheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        padding: const EdgeInsets.all(16),
      ),
      child: CustomText.normal(
        text,
        context: context,
        isBold: true,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  static ElevatedButton google(
    String text, {
    Function? onPressed,
    required BuildContext context,
  }) {
    return ElevatedButton(
      onPressed: onPressed != null
          ? () {
              onPressed();
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        padding: const EdgeInsets.all(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          Image.asset('assets/images/google.png', width: 24),
          CustomText.normal(
            text,
            context: context,
            isBold: true,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  static Widget redEye(RxBool isObscure, {required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        isObscure.value = !isObscure.value;
      },
      child: Icon(
        isObscure.value
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

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
