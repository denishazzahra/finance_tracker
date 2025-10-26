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

  factory WalletModel.fromJson(
    Map<String, dynamic> json, {
    bool isArchive = false,
  }) {
    return WalletModel(
      id: json['id'],
      name: json['name'],
      balance: json['balance']?.toDouble(),
      type: json['type'],
      createdAt: json['createdAt'] != null
          ? (isArchive
                ? DateTime.parse(json['createdAt'])
                : (json['createdAt'] as Timestamp).toDate())
          : null,
      updatedAt: json['updatedAt'] != null
          ? (isArchive
                ? DateTime.parse(json['updatedAt'])
                : (json['updatedAt'] as Timestamp).toDate())
          : null,
    );
  }

  Map<String, dynamic> toJson({
    bool isEdit = false,
    bool isTransaction = false,
    bool isArchive = false,
  }) {
    return {
      if (isTransaction || isArchive) 'id': id,
      'name': name,
      if (balance != null) 'balance': balance,
      'type': type,
      if (createdAt != null)
        'createdAt': !isEdit && !isArchive
            ? FieldValue.serverTimestamp()
            : isArchive
            ? createdAt?.toIso8601String()
            : createdAt,
      if (updatedAt != null)
        'updatedAt': isArchive
            ? updatedAt?.toIso8601String()
            : FieldValue.serverTimestamp(),
    };
  }

  WalletModel removeBalance() {
    return WalletModel(id: id, name: name, balance: null, type: type);
  }
}
