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
  bool? isLinked;
  String? linkedId;

  TransactionModel({
    this.id,
    this.wallet,
    this.amount,
    this.category,
    this.desc,
    this.dateTime,
    this.type,
    this.isLinked,
    this.linkedId,
  });

  factory TransactionModel.fromTransfer(
    TransferModel transfer, {
    bool isFrom = true,
    String? id,
  }) {
    bool isCash = transfer.to.name == "Cash";
    if (isFrom) {
      // print(-(transfer.amount + transfer.adminFee));
      String desc =
          "${isCash ? 'WITHDRAWAL' : 'TOP-UP'} ${CustomConverter.doubleToCurrency(transfer.amount)} TO ${transfer.to.name} WITH ADMIN FEE ${CustomConverter.doubleToCurrency(transfer.adminFee)}";
      return TransactionModel(
        wallet: transfer.from,
        amount: transfer.amount + transfer.adminFee,
        type: 'Expense',
        category: isCash ? 'Others' : 'Top-up',
        desc: desc,
        isLinked: true,
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
        isLinked: true,
        linkedId: id,
      );
    }
  }

  factory TransactionModel.fromJson(
    Map<String, dynamic> json, {
    bool isArchive = false,
  }) {
    return TransactionModel(
      id: json['id'],
      wallet: WalletModel.fromJson(json['wallet'], isArchive: isArchive),
      amount: json['amount'],
      type: json['type'],
      category: json['category'],
      desc: json['desc'],
      dateTime: isArchive
          ? DateTime.parse(json['dateTime'])
          : (json['dateTime'] as Timestamp).toDate(),
      isLinked: json['isLinked'] ?? false,
      linkedId: json['linkedId'],
    );
  }

  Map<String, dynamic> toJson({bool isArchive = false}) {
    return {
      if (isArchive) 'id': id,
      'wallet': wallet?.toJson(isTransaction: true, isArchive: isArchive),
      'amount': type == "Income" ? amount : -amount!,
      'type': type,
      'category': category,
      'desc': desc,
      'dateTime': isArchive
          ? dateTime?.toIso8601String()
          : FieldValue.serverTimestamp(),
      'isLinked': isLinked,
      if (linkedId != null) 'linkedId': linkedId,
    };
  }
}
