import 'package:flutter/material.dart';

class CustomText {
  static Text h1(
    String text, {
    required BuildContext context,
    Color? color,
    isCenter = false,
  }) {
    return Text(
      text,
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 28,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }

  static Text h2(
    String text, {
    required BuildContext context,
    Color? color,
    isCenter = false,
  }) {
    return Text(
      text,
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }

  static Text h3(
    String text, {
    required BuildContext context,
    Color? color,
    isCenter = false,
  }) {
    return Text(
      text,
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }

  static Text big(
    String text, {
    required BuildContext context,
    bool isBold = false,
    bool isCenter = false,
    Color? color,
    isEllipsis = false,
  }) {
    return Text(
      text,
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
      ),
      softWrap: !isEllipsis,
    );
  }

  static Text normal(
    String text, {
    required BuildContext context,
    bool isBold = false,
    bool isCenter = false,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        fontSize: 14,
      ),
      softWrap: true,
    );
  }

  static Text small(
    String text, {
    required BuildContext context,
    bool isBold = false,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        fontSize: 12,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  static bulletList(List<String> items, {required BuildContext context}) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              normal('\u2022', context: context),
              SizedBox(width: 5),
              Expanded(child: normal(str, context: context)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
