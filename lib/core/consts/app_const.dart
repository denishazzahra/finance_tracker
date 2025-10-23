import 'package:finance_tracker/core/theme/finance_color.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

const List<String> walletTypeOptions = [
  "E-Wallet",
  "Bank",
  "Cash",
  "Stock",
  "Others",
];

const transactionTypeOptions = ['Income', 'Expense'];

Map<String, Map<String, dynamic>> walletTypeMap(BuildContext context) => {
  "E-Wallet": {
    'bgCol': Theme.of(context).extension<FinanceColors>()?.ewallet,
    'fgCol': Theme.of(context).extension<FinanceColors>()?.onEwallet,
    'icon': Symbols.wallet,
  },
  "Bank": {
    'bgCol': Theme.of(context).extension<FinanceColors>()?.bank,
    'fgCol': Theme.of(context).extension<FinanceColors>()?.onBank,
    'icon': Symbols.account_balance,
  },
  "Cash": {
    'bgCol': Theme.of(context).extension<FinanceColors>()?.cash,
    'fgCol': Theme.of(context).extension<FinanceColors>()?.onCash,
    'icon': Symbols.money_bag,
  },
  "Stock": {
    'bgCol': Theme.of(context).extension<FinanceColors>()?.stock,
    'fgCol': Theme.of(context).extension<FinanceColors>()?.onStock,
    'icon': Symbols.finance,
  },
  "Others": {
    'bgCol': Theme.of(context).extension<FinanceColors>()?.others,
    'fgCol': Theme.of(context).extension<FinanceColors>()?.onOthers,
    'icon': Symbols.local_atm,
  },
};

Map<String, Map<String, dynamic>> transactionTypeMap(BuildContext context) => {
  "Income": {
    'bgCol': Theme.of(context).extension<FinanceColors>()?.income,
    'fgCol': Theme.of(context).extension<FinanceColors>()?.onIncome,
    'icon': Symbols.trending_up,
  },
  "Expense": {
    'bgCol': Theme.of(context).extension<FinanceColors>()?.expense,
    'fgCol': Theme.of(context).extension<FinanceColors>()?.onExpense,
    'icon': Symbols.trending_down,
  },
};

List<String> transactionCategoryOptions({bool isIncome = false}) => [
  if (!isIncome) "Beauty/Fashion",
  if (!isIncome) "Bills",
  if (isIncome) "Business",
  if (!isIncome) "Education",
  if (!isIncome) "Electronic",
  if (!isIncome) "Entertainment",
  if (!isIncome) "Food",
  if (isIncome) "Gift",
  if (!isIncome) "Health",
  if (isIncome) "Investment",
  if (isIncome) "Refunds",
  if (isIncome) "Salary",
  "Top-up",
  if (!isIncome) "Transport",
  if (!isIncome) "Travel",
  "Others",
];

// Map<String, dynamic> transactionCategoryMap = {
//   "Salary": Symbols.work,
//   "Business": Symbols.business_center,
//   "Investment": Symbols.bar_chart,
//   "Gift": Symbols.featured_seasonal_and_gifts,
//   "Refunds": Symbols.autorenew,
//   "Beauty/Fashion": Symbols.health_and_beauty,
//   "Bills": Symbols.receipt_long,
//   "Education": Symbols.school,
//   "Electronic": Symbols.devices,
//   "Entertainment": Symbols.festival,
//   "Food": Symbols.fastfood,
//   "Health": Symbols.health_and_safety,
//   "Top-up": Symbols.account_balance_wallet,
//   "Transport": Symbols.commute,
//   "Travel": Symbols.travel,
//   "Others": Symbols.category,
// };

Map<String, Map<String, dynamic>> transactionCategoryMap = {
  "Salary": {
    'icon': Symbols.work,
    'bgCol': Colors.deepPurple.shade700,
    'fgCol': Colors.deepPurple.shade200,
  },
  "Business": {
    'icon': Symbols.business_center,
    'bgCol': Colors.brown.shade700,
    'fgCol': Colors.brown.shade200,
  },
  "Investment": {
    'icon': Symbols.bar_chart,
    'bgCol': Colors.lightBlue.shade700,
    'fgCol': Colors.lightBlue.shade200,
  },
  "Gift": {
    'icon': Symbols.featured_seasonal_and_gifts,
    'bgCol': Colors.blue.shade700,
    'fgCol': Colors.blue.shade200,
  },
  "Refunds": {
    'icon': Symbols.autorenew,
    'bgCol': Colors.teal.shade700,
    'fgCol': Colors.teal.shade200,
  },
  "Beauty/Fashion": {
    'icon': Symbols.health_and_beauty,
    'bgCol': Colors.pink.shade700,
    'fgCol': Colors.pink.shade200,
  },
  "Bills": {
    'icon': Symbols.receipt_long,
    'bgCol': Colors.indigo.shade700,
    'fgCol': Colors.indigo.shade200,
  },
  "Education": {
    'icon': Symbols.school,
    'bgCol': Colors.yellow.shade700,
    'fgCol': Colors.yellow.shade200,
  },
  "Electronic": {
    'icon': Symbols.devices,
    'bgCol': Colors.green.shade700,
    'fgCol': Colors.green.shade200,
  },
  "Entertainment": {
    'icon': Symbols.festival,
    'bgCol': Colors.purple.shade700,
    'fgCol': Colors.purple.shade200,
  },
  "Food": {
    'icon': Symbols.fastfood,
    'bgCol': Colors.orange.shade700,
    'fgCol': Colors.orange.shade200,
  },
  "Health": {
    'icon': Symbols.health_and_safety,
    'bgCol': Colors.red.shade700,
    'fgCol': Colors.red.shade200,
  },
  "Top-up": {
    'icon': Symbols.account_balance_wallet,
    'bgCol': Colors.cyan.shade700,
    'fgCol': Colors.cyan.shade200,
  },
  "Transport": {
    'icon': Symbols.commute,
    'bgCol': Colors.lime.shade700,
    'fgCol': Colors.lime.shade200,
  },
  "Travel": {
    'icon': Symbols.travel,
    'bgCol': Colors.lightGreen.shade700,
    'fgCol': Colors.lightGreen.shade200,
  },
  "Others": {
    'icon': Symbols.category,
    'bgCol': Colors.grey.shade700,
    'fgCol': Colors.grey.shade200,
  },
};
