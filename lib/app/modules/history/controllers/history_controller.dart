import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/transaction_service.dart';
import '../../../data/models/transaction_model.dart';

class HistoryController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<TransactionModel?> transactions = <TransactionModel?>[].obs;
  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      isLoading.value = true;
      await getAllTransactions();
    } catch (e) {
      Get.snackbar(
        'Failed',
        "Failed to fetch data: ${e.toString()}",
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllTransactions() async {
    transactions.value = (await TransactionService.get())
        .map((transaction) => TransactionModel.fromJson(transaction))
        .toList();
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
