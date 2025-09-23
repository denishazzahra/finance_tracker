import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomDivider {
  static Widget withText(
    String text, {
    required BuildContext context,
    Color? color,
  }) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: color ?? Theme.of(context).colorScheme.surface),
        ),
        CustomText.small(text, context: context),
        Expanded(
          child: Divider(color: color ?? Theme.of(context).colorScheme.surface),
        ),
      ],
    );
  }
}
