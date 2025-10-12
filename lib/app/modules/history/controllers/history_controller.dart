import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/transaction_service.dart';
import '../../../data/models/transaction_model.dart';

class HistoryController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  RxBool resetBalance = true.obs;
  SharedPreferences prefs = Get.find<SharedPreferences>();

  @override
  void onInit() {
    super.onInit();
    // initializeData();
  }

  Future<void> initializeData() async {
    isLoading.value = true;
    await getAllTransactions();
    isLoading.value = false;
  }

  Future<void> setTransactionCache() async {
    await prefs.setString(
      'transactions',
      jsonEncode(transactions.map((e) => e.toJson(isArchive: true)).toList()),
    );
  }

  void getTransactionCache() {
    String? temp = prefs.getString('transactions');
    if (temp != null) {
      List<dynamic> json = jsonDecode(temp);
      transactions.value = json
          .map(
            (e) => TransactionModel.fromJson(
              Map<String, dynamic>.from(e),
              isArchive: true,
            ),
          )
          .toList();
    } else {
      transactions.value = [];
    }
  }

  Future<void> getAllTransactions() async {
    try {
      transactions.value = (await TransactionService.get())
          .map((transaction) => TransactionModel.fromJson(transaction))
          .toList();
      await setTransactionCache();
    } catch (e) {
      getTransactionCache();
      Get.snackbar(
        'Failed',
        "Failed to fetch data: ${e.toString()}",
        margin: EdgeInsets.all(16),
      );
    }
  }

  Future<void> deleteTransaction(TransactionModel selectedTrans) async {
    try {
      String id = selectedTrans.id!;
      transactions.remove(selectedTrans);

      // also delete the linked transaction (ex: topup or transfer money)
      if (selectedTrans.isLinked ?? false) {
        TransactionModel? linkedTrans;
        if (selectedTrans.linkedId != null) {
          linkedTrans = transactions.firstWhereOrNull(
            (e) => e.id == selectedTrans.linkedId,
          );
        } else {
          linkedTrans = transactions.firstWhereOrNull((e) => e.linkedId == id);
        }
        transactions.remove(linkedTrans);
        if (linkedTrans != null) {
          await TransactionService.delete(
            linkedTrans,
            resetBalance: resetBalance.value,
          );
        }
      }
      await TransactionService.delete(
        selectedTrans,
        resetBalance: resetBalance.value,
      );

      await setTransactionCache();
    } on FirebaseException catch (e) {
      Get.snackbar(
        'Failed',
        "Failed to delete transaction: ${e.message}",
        margin: EdgeInsets.all(16),
      );
    }
  }

  bool checkSameDay({DateTime? prev, DateTime? curr, required int index}) {
    if (index != 0 &&
        prev?.year == curr?.year &&
        prev?.month == curr?.month &&
        prev?.day == curr?.day) {
      return true;
    }
    return false;
  }
}
