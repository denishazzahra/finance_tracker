import 'package:flutter/material.dart';

class CustomIcon {
  static Widget display({
    required Color bgCol,
    required Color iconCol,
    required IconData icon,
    double width = 36,
    double iconSize = 24,
    bool isCircle = false,
  }) {
    return Container(
      padding: isCircle ? EdgeInsets.all(8) : null,
      width: !isCircle ? width : iconSize + 16,
      height: !isCircle ? width : iconSize + 16,
      decoration: BoxDecoration(
        color: bgCol,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: !isCircle ? BorderRadius.all(Radius.circular(4)) : null,
      ),
      child: Center(
        child: Icon(icon, color: iconCol, size: iconSize),
      ),
    );
  }
}
