import 'wallet_model.dart';

class TransferModel {
  WalletModel from;
  WalletModel to;
  double amount;
  double adminFee;

  TransferModel({
    required this.from,
    required this.to,
    required this.amount,
    this.adminFee = 0,
  });
}
