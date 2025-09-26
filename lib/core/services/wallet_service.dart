import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/app/data/models/transfer_model.dart';
import 'package:finance_tracker/app/data/models/wallet_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../app/data/models/transaction_model.dart';
import 'transaction_service.dart';

class WalletService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> create({required WalletModel wallet}) async {
    final User? user = _auth.currentUser;
    await _db
        .collection('users')
        .doc(user?.uid)
        .collection('wallets')
        .add(wallet.toJson());
  }

  static Future<void> update({required WalletModel wallet}) async {
    final User? user = _auth.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('wallets')
        .doc(wallet.id)
        .update(wallet.toJson(isEdit: true));
  }

  static Future<void> delete({required String? id}) async {
    final User? user = _auth.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('wallets')
        .doc(id)
        .delete();
  }

  static Future<List<Map<String, dynamic>>> get() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    final snapshot = await _db
        .collection('users')
        .doc(user.uid)
        .collection('wallets')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {'id': doc.id, ...data};
    }).toList();
  }

  static Future<void> transfer({required TransferModel transfer}) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    final fromRef = _db
        .collection('users')
        .doc(user.uid)
        .collection('wallets')
        .doc(transfer.from.id);

    final toRef = _db
        .collection('users')
        .doc(user.uid)
        .collection('wallets')
        .doc(transfer.to.id);

    await _db.runTransaction((transaction) async {
      final fromSnap = await transaction.get(fromRef);
      final toSnap = await transaction.get(toRef);

      if (!fromSnap.exists || !toSnap.exists) {
        throw Exception("Wallet not found");
      }

      print('hereeee');
      print(transfer.from.id);
      print(transfer.to.id);

      final fromBalance = (fromSnap['balance'] as num).toDouble();
      final totalDeduction = transfer.amount + transfer.adminFee;

      print(fromBalance);
      print(totalDeduction);

      if (fromBalance < totalDeduction) {
        throw Exception("Not enough balance in source wallet");
      }

      print("aaaaa");

      // Update both atomically
      transaction.update(fromRef, {
        'balance': FieldValue.increment(-totalDeduction),
      });

      transaction.update(toRef, {
        'balance': FieldValue.increment(transfer.amount),
      });

      print("bbbb");
    });

    await TransactionService.create(TransactionModel.fromTransfer(transfer));
    await TransactionService.create(
      TransactionModel.fromTransfer(transfer, isFrom: false),
    );
  }
}
