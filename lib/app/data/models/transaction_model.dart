import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/app/data/models/transfer_model.dart';

import '../../../core/utils/custom_converter.dart';
import 'wallet_model.dart';

class TransactionModel {
  String? id;
  WalletModel? wallet;
  double? amount;
  String? type;
  String? category;
  String? desc;
  DateTime? dateTime;

  TransactionModel({
    this.id,
    this.wallet,
    this.amount,
    this.category,
    this.desc,
    this.dateTime,
    this.type,
  });

  factory TransactionModel.fromTransfer(
    TransferModel transfer, {
    bool isFrom = true,
  }) {
    String desc = isFrom
        ? "TO ${transfer.to.name} WITH ADMIN FEE ${CustomConverter.doubleToCurrency(transfer.adminFee)}"
        : "FROM ${transfer.from.name}";
    return TransactionModel(
      wallet: isFrom ? transfer.from : transfer.to,
      amount: isFrom
          ? -1 * (transfer.amount + transfer.adminFee)
          : transfer.amount,
      type: isFrom ? 'Expense' : 'Income',
      category: "Top-up",
      desc:
          "${transfer.to.name == 'Cash' ? 'WITHDRAWAL' : 'TOP-UP'} ${CustomConverter.doubleToCurrency(transfer.amount)} $desc",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wallet': wallet?.toJson(isTransaction: true),
      'amount': amount,
      'type': type,
      'category': category,
      'desc': desc,
      'dateTime': FieldValue.serverTimestamp(),
    };
  }
}
