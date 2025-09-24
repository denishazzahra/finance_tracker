import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/wallet_service.dart';
import '../../../data/models/wallet_model.dart';

class DashboardController extends GetxController {
  RxBool isMenuExpanded = false.obs;
  RxBool isLoading = true.obs;
  RxDouble totalBalance = 0.0.obs;
  late final TextEditingController walletName, initBalance;
  RxList<WalletModel> wallets = <WalletModel>[].obs;
  RxString type = "E-Wallet".obs;
  List<String> typeOptions = ["E-Wallet", "Bank", "Cash", "Stock", "Others"];
  Rx<DateTime> lastUpdated = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    initializeData();
    walletName = TextEditingController();
    initBalance = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    walletName.dispose();
    initBalance.dispose();
  }

  Future<void> initializeData() async {
    try {
      isLoading.value = true;
      await getAllWallets();
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

  void toggleMenu() {
    isMenuExpanded.toggle();
  }

  void resetForm() {
    walletName.clear();
    initBalance.clear();
  }

  void onChangeType(String val) {
    type.value = val;
  }

  Future<void> createNewWallet() async {
    try {
      isLoading.value = true;
      WalletModel wallet = WalletModel(
        name: walletName.text.trim(),
        balance: double.tryParse(
          initBalance.text.trim().replaceAll(RegExp(r'[^0-9]'), ''),
        ),
        type: type.value,
      );
      if (wallet.name == '' || wallet.balance == null) {
        Get.snackbar(
          'Empty field',
          "Please fill all the fields before continuing.",
          margin: EdgeInsets.all(16),
        );
      } else {
        await WalletService.create(wallet: wallet);
        Get.back();
        await Future.delayed(Duration(milliseconds: 100));
        Get.snackbar(
          'Success',
          "Wallet created successfully.",
          margin: EdgeInsets.all(16),
        );
        await getAllWallets();
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        "Failed to create wallet: ${e.toString()}",
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllWallets() async {
    totalBalance.value = 0;
    wallets.value = (await WalletService.get()).map((wallet) {
      WalletModel temp = WalletModel.fromJson(wallet);
      totalBalance.value += (temp.balance ?? 0);
      return temp;
    }).toList();
    lastUpdated.value = DateTime.now();
  }
}
