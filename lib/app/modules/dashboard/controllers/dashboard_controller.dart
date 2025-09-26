import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/wallet_service.dart';
import '../../../data/models/transfer_model.dart';
import '../../../data/models/wallet_model.dart';

class DashboardController extends GetxController {
  RxBool isMenuExpanded = false.obs;
  RxBool isLoading = true.obs;
  RxDouble totalBalance = 0.0.obs;
  late final TextEditingController walletName, amount, adminFee;
  RxList<WalletModel> wallets = <WalletModel>[].obs;
  Rx<String?> walletType = Rx<String?>(null);
  Rx<String?> transactionType = Rx<String?>(null);
  Rx<DateTime> lastUpdated = DateTime.now().obs;
  Rx<WalletModel?> fromWallet = Rx<WalletModel?>(null);
  Rx<WalletModel?> toWallet = Rx<WalletModel?>(null);
  Rx<WalletModel?> selectedWallet = Rx<WalletModel?>(null);

  @override
  void onInit() {
    super.onInit();
    initializeData();
    walletName = TextEditingController();
    amount = TextEditingController();
    adminFee = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    walletName.dispose();
    amount.dispose();
    adminFee.dispose();
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
    amount.clear();
    adminFee.clear();
    walletType.value = null;
    transactionType.value = null;
    selectedWallet.value = null;
    fromWallet.value = null;
    toWallet.value = null;
  }

  void onChangeType(String val) {
    walletType.value = val;
  }

  void onChangeFrom(WalletModel val) {
    toWallet.value = null;
    fromWallet.value = val;
  }

  void onChangeTo(WalletModel val) {
    toWallet.value = val;
  }

  Future<void> createNewWallet() async {
    try {
      isLoading.value = true;
      WalletModel wallet = WalletModel(
        name: walletName.text.trim(),
        balance: double.tryParse(
          amount.text.trim().replaceAll(RegExp(r'[^0-9]'), ''),
        ),
        type: walletType.value,
      );
      if (wallet.name == '' ||
          wallet.balance == null ||
          walletType.value == null) {
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

  Future<void> transferMoney() async {
    try {
      isLoading.value = true;
      if (fromWallet.value == null ||
          toWallet.value == null ||
          amount.text.trim().isEmpty) {
        Get.snackbar(
          'Empty field',
          "Please fill all the fields before continuing.",
          margin: EdgeInsets.all(16),
        );
      } else {
        TransferModel transfer = TransferModel(
          from: fromWallet.value!,
          to: toWallet.value!,
          amount: double.parse(
            amount.text.trim().replaceAll(RegExp(r'[^0-9]'), ''),
          ),
          adminFee:
              double.tryParse(
                adminFee.text.trim().replaceAll(RegExp(r'[^0-9]'), ''),
              ) ??
              0,
        );
        await WalletService.transfer(transfer: transfer);
        Get.back();
        await Future.delayed(Duration(milliseconds: 100));
        Get.snackbar(
          'Success',
          "Money transfered successfully.",
          margin: EdgeInsets.all(16),
        );
        await getAllWallets();
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        "Failed to transfer money: ${e.toString()}",
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateWallet() async {
    try {
      WalletModel wallet = WalletModel(
        id: selectedWallet.value?.id,
        name: walletName.text.trim(),
        balance: double.tryParse(
          amount.text.trim().replaceAll(RegExp(r'[^0-9]'), ''),
        ),
        type: walletType.value,
      );
      if (wallet.name == '' ||
          wallet.balance == null ||
          walletType.value == null) {
        Get.snackbar(
          'Empty field',
          "Please fill all the fields before continuing.",
          margin: EdgeInsets.all(16),
        );
      } else {
        isLoading.value = true;
        await WalletService.update(wallet: wallet);
        Get.back();
        await Future.delayed(Duration(milliseconds: 100));
        Get.snackbar(
          'Success',
          "Wallet updated successfully.",
          margin: EdgeInsets.all(16),
        );
        await getAllWallets();
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        "Failed to update wallet: ${e.toString()}",
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteWallet(String id) async {
    try {
      isLoading.value = true;
      await WalletService.delete(id: id);
      Get.back();
      await Future.delayed(Duration(milliseconds: 100));
      Get.snackbar(
        'Success',
        "Wallet updated successfully.",
        margin: EdgeInsets.all(16),
      );
      await getAllWallets();
    } catch (e) {
      Get.snackbar(
        'Failed',
        "Failed to update wallet: ${e.toString()}",
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
