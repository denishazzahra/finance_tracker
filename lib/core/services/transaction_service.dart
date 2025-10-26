import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/app/data/models/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../app/data/models/transfer_model.dart';
import '../utils/custom_converter.dart';
import 'wallet_service.dart';

class TransactionService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<String> create(
    TransactionModel transaction, {
    bool isTopup = false,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");
    if (!isTopup) {
      WalletService.updateBalance(
        wallet: transaction.wallet!,
        amount: transaction.toJson()['amount'],
      );
    }
    final snapshot = await _db
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .add(
          transaction.transfer == null
              ? transaction.toJson()
              : transaction.toJsonFromTransfer(),
        );

    return snapshot.id;
  }

  static Future<List<Map<String, dynamic>>> get({int monthDiff = 0}) async {
    final bottomLimit = CustomConverter.nMonthDiff(monthDiff);
    int upperLimitMonth = bottomLimit.month + 1;
    if (upperLimitMonth == 13) upperLimitMonth = 1;
    final upperLimitYear = bottomLimit.year + (upperLimitMonth == 1 ? 1 : 0);
    final upperLimit = DateTime(upperLimitYear, upperLimitMonth);
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");
    final snapshot = await _db
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .where(
          'dateTime',
          isGreaterThanOrEqualTo: bottomLimit,
          isLessThan: upperLimit,
        )
        .orderBy('dateTime', descending: true)
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {'id': doc.id, ...data};
    }).toList();
  }

  static Future<void> delete(
    TransactionModel transaction, {
    bool resetBalance = true,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");
    await _db
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .doc(transaction.id)
        .delete();
    if (resetBalance) {
      if (transaction.transfer != null) {
        final TransferModel transfer = transaction.transfer!;
        final double amountFrom =
            transfer.amount +
            (transfer.adminFeeOn == AdminFeeOn.sender ? 1 : 0) *
                transfer.adminFee;
        final double amountTo =
            transfer.amount -
            (transfer.adminFeeOn == AdminFeeOn.recipient ? 1 : 0) *
                transfer.adminFee;
        await WalletService.updateBalance(
          wallet: transfer.from,
          amount: amountFrom,
        );
        await WalletService.updateBalance(
          wallet: transfer.to,
          amount: -amountTo,
        );
      } else {
        await WalletService.updateBalance(
          wallet: transaction.wallet!,
          amount: -transaction.amount!,
        );
      }
    }
  }
}
