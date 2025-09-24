import 'package:flutter/material.dart';

@immutable
class FinanceColors extends ThemeExtension<FinanceColors> {
  final Color income;
  final Color onIncome;
  final Color expense;
  final Color onExpense;
  final Color ewallet;
  final Color onEwallet;
  final Color bank;
  final Color onBank;
  final Color cash;
  final Color onCash;
  final Color others;
  final Color onOthers;
  final Color stock;
  final Color onStock;

  const FinanceColors({
    required this.ewallet,
    required this.onEwallet,
    required this.bank,
    required this.onBank,
    required this.cash,
    required this.onCash,
    required this.others,
    required this.onOthers,
    required this.stock,
    required this.onStock,
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
    Color? ewallet,
    Color? onEwallet,
    Color? bank,
    Color? onBank,
    Color? cash,
    Color? onCash,
    Color? others,
    Color? onOthers,
    Color? stock,
    Color? onStock,
  }) {
    return FinanceColors(
      income: income ?? this.income,
      onIncome: onIncome ?? this.onIncome,
      expense: expense ?? this.expense,
      onExpense: onExpense ?? this.onExpense,
      ewallet: ewallet ?? this.ewallet,
      onEwallet: onEwallet ?? this.onEwallet,
      bank: bank ?? this.bank,
      onBank: onBank ?? this.onBank,
      cash: cash ?? this.cash,
      onCash: onCash ?? this.onCash,
      others: others ?? this.others,
      onOthers: onOthers ?? this.onOthers,
      stock: stock ?? this.stock,
      onStock: onStock ?? this.onStock,
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
      ewallet: Color.lerp(ewallet, other.ewallet, t)!,
      onEwallet: Color.lerp(onEwallet, other.onEwallet, t)!,
      bank: Color.lerp(bank, other.bank, t)!,
      onBank: Color.lerp(onBank, other.onBank, t)!,
      cash: Color.lerp(cash, other.cash, t)!,
      onCash: Color.lerp(onCash, other.onCash, t)!,
      others: Color.lerp(others, other.others, t)!,
      onOthers: Color.lerp(onOthers, other.onOthers, t)!,
      stock: Color.lerp(stock, other.stock, t)!,
      onStock: Color.lerp(onStock, other.onStock, t)!,
    );
  }
}
