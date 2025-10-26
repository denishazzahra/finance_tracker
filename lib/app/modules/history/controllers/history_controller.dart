import 'dart:convert';

import 'package:finance_tracker/core/controllers/network_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/transaction_service.dart';
import '../../../../core/utils/custom_converter.dart';
import '../../../data/models/transaction_model.dart';

class HistoryController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  RxBool resetBalance = true.obs;
  SharedPreferences prefs = Get.find<SharedPreferences>();
  NetworkController network = Get.find<NetworkController>();
  RxBool hasInit = false.obs;
  RxInt monthDiff = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  Future<void> initializeData() async {
    isLoading.value = true;
    await getAllTransactions();
    isLoading.value = false;
  }

  Future<void> setTransactionCache({DateTime? date}) async {
    date = date ?? DateTime.now();
    await prefs.setString(
      'transactions_${date.year}-${date.month}',
      jsonEncode(transactions.map((e) => e.toJson(isArchive: true)).toList()),
    );
  }

  bool isCacheExists({DateTime? date}) {
    date = date ?? DateTime.now();
    return prefs.getString('transactions_${date.year}-${date.month}') != null;
  }

  void getTransactionCache({DateTime? date}) {
    date = date ?? DateTime.now();
    String? temp = prefs.getString('transactions_${date.year}-${date.month}');
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

  Future<void> changeMonth(int diff) async {
    try {
      monthDiff.value += diff;
      final tempDate = CustomConverter.nMonthDiff(monthDiff.value);
      if (isCacheExists(date: tempDate)) {
        getTransactionCache(date: tempDate);
      } else {
        await getAllTransactions();
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        "Failed to fetch data: ${e.toString().replaceFirst('Exception: ', '')}",
        margin: EdgeInsets.all(16),
      );
    }
  }

  Future<void> getAllTransactions() async {
    try {
      DateTime tempDate = CustomConverter.nMonthDiff(monthDiff.value);
      if (await network.ensureConnection()) {
        if (hasInit.value) {
          Get.snackbar(
            "You're back online",
            "Loading data from database...",
            margin: EdgeInsets.all(16),
          );
        }
        transactions.value =
            (await TransactionService.get(monthDiff: monthDiff.value))
                .map((transaction) => TransactionModel.fromJson(transaction))
                .toList();
        await setTransactionCache(date: tempDate);
      } else {
        hasInit.value = true;
        getTransactionCache(date: tempDate);
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        "Failed to fetch data: ${e.toString().replaceFirst('Exception: ', '')}",
        margin: EdgeInsets.all(16),
      );
    }
  }

  Future<void> deleteTransaction(TransactionModel selectedTrans) async {
    try {
      transactions.remove(selectedTrans);
      DateTime tempDate = CustomConverter.nMonthDiff(monthDiff.value);
      await TransactionService.delete(
        selectedTrans,
        resetBalance: resetBalance.value,
      );

      await setTransactionCache(date: tempDate);
    } on FirebaseException catch (e) {
      Get.snackbar(
        'Failed',
        "Failed to delete transaction: ${e.toString().replaceFirst('Exception: ', '')}",
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
