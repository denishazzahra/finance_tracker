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
    'icon': Symbols.wallet,
  },
  "Expense": {
    'bgCol': Theme.of(context).extension<FinanceColors>()?.expense,
    'fgCol': Theme.of(context).extension<FinanceColors>()?.onExpense,
    'icon': Symbols.account_balance,
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

Map<String, dynamic> transactionCategoryMap = {
  "Salary": Symbols.work,
  "Business": Symbols.business_center,
  "Investment": Symbols.bar_chart,
  "Gift": Symbols.featured_seasonal_and_gifts,
  "Refunds": Symbols.autorenew,
  "Beauty/Fashion": Symbols.health_and_beauty,
  "Bills": Symbols.receipt_long,
  "Education": Symbols.school,
  "Electronic": Symbols.devices,
  "Entertainment": Symbols.festival,
  "Food": Symbols.fastfood,
  "Health": Symbols.health_and_safety,
  "Top-up": Symbols.account_balance_wallet,
  "Transport": Symbols.commute,
  "Travel": Symbols.travel,
  "Others": Symbols.category,
};
