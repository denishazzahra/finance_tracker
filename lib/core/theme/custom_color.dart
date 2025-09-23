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
    income: Colors.blue.shade300,
    onIncome: Colors.blue.shade800,
    expense: Colors.red.shade200,
    onExpense: Colors.red.shade700,
  );

  static final Color primaryDark = Colors.orange.shade200;
  static final Color backgroundDark = Color(0xFF121212);
  static final Color cardDark = Color(0xFF1e1e1e);
  static final Color chipDark = Color(0xFF2f2f2f);
  static final Color incomeDark = Colors.blue.shade200;
  static final Color expenseDark = Colors.red.shade200;
  static final Color onPrimaryDark = Color(0xFF121212);
  static final Color onBackgroundDark = Color(0xFFFBFBFB);
  static final Color onCardDark = Color(0xFFFBFBFB);
  static final Color onChipDark = Color(0xFFFBFBFB);
  static final Color onIncomeDark = Colors.blue.shade700;
  static final Color onExpenseDark = Colors.red.shade700;
  static final financeDark = FinanceColors(
    income: Colors.blue.shade200,
    onIncome: Colors.blue.shade700,
    expense: Colors.red.shade200,
    onExpense: Colors.red.shade700,
  );
}
