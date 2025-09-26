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
    bool isCash = transfer.to.name == "Cash";
    if (isFrom) {
      String desc =
          "${isCash ? 'WITHDRAWAL' : 'TOP-UP'} ${CustomConverter.doubleToCurrency(transfer.amount)} TO ${transfer.to.name} WITH ADMIN FEE ${CustomConverter.doubleToCurrency(transfer.adminFee)}";
      return TransactionModel(
        wallet: transfer.from,
        amount: transfer.amount + transfer.adminFee,
        type: 'Expense',
        category: isCash ? 'Others' : 'Top-up',
        desc: desc,
      );
    } else {
      String desc =
          "${isCash ? 'WITHDRAWAL' : 'TOP-UP'} ${CustomConverter.doubleToCurrency(transfer.amount)} FROM ${transfer.from.name}";
      return TransactionModel(
        wallet: transfer.to,
        amount: transfer.amount,
        type: isCash ? 'Others' : 'Income',
        category: 'Top-up',
        desc: desc,
      );
    }
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      wallet: WalletModel.fromJson(json['wallet']),
      amount: json['amount'],
      type: json['type'],
      category: json['category'],
      desc: json['desc'],
      dateTime: json['dateTime'],
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
