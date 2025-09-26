import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/app/data/models/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'wallet_service.dart';

class TransactionService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> create(
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
    await _db
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .add(transaction.toJson());
  }

  static Future<List<Map<String, dynamic>>> get() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");
    final snapshot = await _db
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .orderBy('dateTime', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {'id': doc.id, ...data};
    }).toList();
  }
}
