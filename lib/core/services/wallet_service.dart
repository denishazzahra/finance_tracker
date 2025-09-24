import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/app/data/models/wallet_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    // final User? user = _auth.currentUser;
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user?.uid)
    //     .collection('wallets')
    //     .get();
  }

  static Future<List<Map<String, dynamic>>> get() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    final snapshot = await _db
        .collection('users')
        .doc(user.uid)
        .collection('wallets')
        .get();

    // Convert docs into List<Map<String, dynamic>>
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id, // keep walletId
        ...data,
      };
    }).toList();
  }
}
