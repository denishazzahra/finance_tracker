import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/app/data/models/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> create(TransactionModel transaction) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");
    print(transaction.toJson());
    await _db
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .add(transaction.toJson());
  }
}
