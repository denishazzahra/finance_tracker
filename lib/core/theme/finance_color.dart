import 'package:flutter/material.dart';

@immutable
class FinanceColors extends ThemeExtension<FinanceColors> {
  final Color income;
  final Color onIncome;
  final Color expense;
  final Color onExpense;

  const FinanceColors({
    required this.income,
    required this.onIncome,
    required this.expense,
    required this.onExpense,
  });

  @override
  FinanceColors copyWith({
    Color? income,
    Color? onIncome,
    Color? expense,
    Color? onExpense,
  }) {
    return FinanceColors(
      income: income ?? this.income,
      onIncome: onIncome ?? this.onIncome,
      expense: expense ?? this.expense,
      onExpense: onExpense ?? this.onExpense,
    );
  }

  @override
  FinanceColors lerp(ThemeExtension<FinanceColors>? other, double t) {
    if (other is! FinanceColors) return this;
    return FinanceColors(
      income: Color.lerp(income, other.income, t)!,
      onIncome: Color.lerp(onIncome, other.onIncome, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      onExpense: Color.lerp(onExpense, other.onExpense, t)!,
    );
  }
}
