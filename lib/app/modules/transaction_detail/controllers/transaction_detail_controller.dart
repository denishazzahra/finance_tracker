import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/controllers/network_controller.dart';
import '../../../../core/services/transaction_service.dart';
import '../../../data/models/transaction_model.dart';

class TransactionDetailController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<TransactionModel?> transaction = Rx<TransactionModel?>(null);
  NetworkController network = Get.find<NetworkController>();

  Future<void> initializeData() async {
    try {
      isLoading.value = true;
      String? transactionId = Get.parameters['id'];
      if (transactionId == null) {
        Get.offAllNamed('/home');
        Get.snackbar(
          'Failed',
          'Transaction not found. Please make sure the transaction ID is correct.',
          margin: EdgeInsets.all(16),
        );
      } else {
        if (await network.ensureConnection()) {
          final snapshot = await TransactionService.getById(id: transactionId);
          if (snapshot != null) {
            transaction.value = TransactionModel.fromJson(snapshot);
          } else {
            Get.offAllNamed('/home');
            Get.snackbar(
              'Failed',
              'Transaction not found. Please make sure the transaction ID is correct.',
              margin: EdgeInsets.all(16),
            );
          }
        }
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        e.toString().replaceFirst('Exception: ', ''),
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
