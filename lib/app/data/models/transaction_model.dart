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
  TransferModel? transfer;

  TransactionModel({
    this.id,
    this.wallet,
    this.amount,
    this.category,
    this.desc,
    this.dateTime,
    this.type,
    this.transfer,
  });

  factory TransactionModel.fromTransfer(TransferModel transfer) {
    bool isCash = transfer.to.name == "Cash";

    String desc =
        "${isCash ? 'WITHDRAWAL' : 'TOP-UP'} ${CustomConverter.doubleToCurrency(transfer.amount)} TO ${transfer.to.name} WITH ADMIN FEE ${CustomConverter.doubleToCurrency(transfer.adminFee)} (ADMIN FEE on ${transfer.adminFeeOn.name})";
    return TransactionModel(
      type: 'Expense',
      amount: transfer.adminFee,
      category: isCash ? 'Others' : 'Top-up',
      desc: desc,
      transfer: transfer,
    );
  }

  Map<String, dynamic> toJsonFromTransfer({bool isArchive = false}) {
    return {
      'type': type,
      'amount': -amount!,
      'category': category,
      'desc': desc,
      'transfer': transfer?.toJson(),
      'dateTime': isArchive
          ? dateTime?.toIso8601String()
          : FieldValue.serverTimestamp(),
    };
  }

  factory TransactionModel.fromJson(
    Map<String, dynamic> json, {
    bool isArchive = false,
  }) {
    return TransactionModel(
      id: json['id'],
      wallet: json.containsKey('wallet')
          ? WalletModel.fromJson(json['wallet'], isArchive: isArchive)
          : null,
      amount: json['amount'].toDouble(),
      type: json['type'],
      category: json['category'],
      desc: json['desc'],
      dateTime: isArchive
          ? DateTime.parse(json['dateTime'])
          : (json['dateTime'] as Timestamp).toDate(),
      transfer: json.containsKey('transfer')
          ? TransferModel.fromJson(json['transfer'])
          : null,
    );
  }

  Map<String, dynamic> toJson({bool isArchive = false}) {
    return {
      if (isArchive) 'id': id,
      if (transfer == null)
        'wallet': wallet?.toJson(isTransaction: true, isArchive: isArchive),
      'amount': type == "Income" ? amount : -amount!,
      'type': type,
      'category': category,
      'desc': desc,
      'dateTime': isArchive
          ? dateTime?.toIso8601String()
          : FieldValue.serverTimestamp(),
      if (transfer != null) 'transfer': transfer?.toJson(),
    };
  }
}
