import 'wallet_model.dart';

enum AdminFeeOn { sender, recipient }

class TransferModel {
  WalletModel from;
  WalletModel to;
  double amount;
  double adminFee;
  AdminFeeOn adminFeeOn;

  TransferModel({
    required this.from,
    required this.to,
    required this.amount,
    this.adminFee = 0,
    this.adminFeeOn = AdminFeeOn.sender,
  });

  factory TransferModel.fromJson(Map<String, dynamic> json) {
    return TransferModel(
      from: WalletModel.fromJson(json['from']),
      to: WalletModel.fromJson(json['to']),
      amount: json['amount'].toDouble(),
      adminFee: json['adminFee'].toDouble(),
      adminFeeOn: AdminFeeOn.values.byName(json['adminFeeOn']),
    );
  }

  Map<String, dynamic> toJson({bool isArchive = false}) {
    return {
      'from': from.removeBalance().toJson(
        isTransaction: true,
        isArchive: isArchive,
      ),
      'to': to.removeBalance().toJson(
        isTransaction: true,
        isArchive: isArchive,
      ),
      'amount': amount,
      'adminFee': adminFee,
      'adminFeeOn': adminFeeOn.name,
    };
  }
}
