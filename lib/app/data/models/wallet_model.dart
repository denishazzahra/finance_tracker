import 'package:cloud_firestore/cloud_firestore.dart';

class WalletModel {
  String? id;
  String? name;
  double? balance;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  WalletModel({
    this.id,
    this.name,
    this.balance = 0,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'],
      name: json['name'],
      balance: json['balance']?.toDouble(),
      type: json['type'],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson({bool isEdit = false}) {
    return {
      'name': name,
      'balance': balance,
      'type': type,
      (isEdit ? 'updatedAt' : 'createdAt'): FieldValue.serverTimestamp(),
    };
  }
}
