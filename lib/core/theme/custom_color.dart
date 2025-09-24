import 'package:finance_tracker/core/theme/finance_color.dart';
import 'package:flutter/material.dart';

class CustomColor {
  static final Color backgroundLight = Colors.white;
  static final Color primaryLight = Colors.orange.shade300;
  static final Color cardLight = Color(0xFFf0f0f0);
  static final Color chipLight = Color(0xFFdfdfdf);
  static final Color onPrimaryLight = Color(0xFF121212);
  static final Color onBackgroundLight = Color(0xFF030507);
  static final Color onCardLight = Color(0xFF121212);
  static final Color onChipLight = Color(0xFF121212);
  static final financeLight = FinanceColors(
    income: Colors.green.shade200,
    onIncome: Colors.green.shade800,
    expense: Colors.red.shade200,
    onExpense: Colors.red.shade700,
    ewallet: Colors.blue.shade200,
    onEwallet: Colors.blue.shade800,
    bank: Colors.deepPurple.shade200,
    onBank: Colors.deepPurple.shade800,
    cash: Colors.pink.shade200,
    onCash: Colors.pink.shade700,
    others: Colors.cyan.shade200,
    onOthers: Colors.cyan.shade800,
    stock: Colors.deepOrange.shade200,
    onStock: Colors.deepOrange.shade700,
  );

  static final Color primaryDark = Colors.orange.shade200;
  static final Color backgroundDark = Color(0xFF121212);
  static final Color cardDark = Color(0xFF1e1e1e);
  static final Color chipDark = Color(0xFF2f2f2f);
  static final Color onPrimaryDark = Color(0xFF121212);
  static final Color onBackgroundDark = Color(0xFFFBFBFB);
  static final Color onCardDark = Color(0xFFFBFBFB);
  static final Color onChipDark = Color(0xFFFBFBFB);
  static final financeDark = FinanceColors(
    income: Colors.green.shade700,
    onIncome: Colors.green.shade200,
    expense: Colors.red.shade700,
    onExpense: Colors.red.shade200,
    ewallet: Colors.blue.shade700,
    onEwallet: Colors.blue.shade100,
    bank: Colors.deepPurple.shade700,
    onBank: Colors.deepPurple.shade100,
    cash: Colors.pink.shade700,
    onCash: Colors.pink.shade100,
    others: Colors.cyan.shade800,
    onOthers: Colors.cyan.shade100,
    stock: Colors.deepOrange.shade700,
    onStock: Colors.deepOrange.shade100,
  );
}
