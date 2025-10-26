import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/core/controllers/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/transaction_service.dart';
import '../../../../core/services/wallet_service.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/models/transfer_model.dart';
import '../../../data/models/wallet_model.dart';

class DashboardController extends GetxController {
  final network = Get.find<NetworkController>();
  RxBool isMenuExpanded = false.obs;
  RxBool isLoading = true.obs;
  RxDouble totalBalance = 0.0.obs;
  late final TextEditingController walletName, amount, adminFee, desc;
  RxList<WalletModel> wallets = <WalletModel>[].obs;
  Rx<String?> walletType = Rx<String?>(null);
  Rx<String?> transactionType = Rx<String?>(null);
  Rx<String?> transactionCategory = Rx<String?>(null);
  Rx<DateTime> lastUpdated = DateTime.now().obs;
  Rx<WalletModel?> fromWallet = Rx<WalletModel?>(null);
  Rx<WalletModel?> toWallet = Rx<WalletModel?>(null);
  Rx<WalletModel?> selectedWallet = Rx<WalletModel?>(null);
  Rx<AdminFeeOn> adminFeeOn = AdminFeeOn.sender.obs;
  RxString adminFeeStr = ''.obs;
  SharedPreferences prefs = Get.find<SharedPreferences>();
  RxBool hasInit = false.obs;

  @override
  void onInit() {
    super.onInit();
    walletName = TextEditingController();
    amount = TextEditingController();
    adminFee = TextEditingController();
    desc = TextEditingController();
    initializeData();
  }

  @override
  void onClose() {
    walletName.dispose();
    amount.dispose();
    adminFee.dispose();
    desc.dispose();
    super.onClose();
  }

  Future<void> initializeData() async {
    isLoading.value = true;
    await getAllWallets();
    isLoading.value = false;
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
    transactionCategory.value = null;
    desc.clear();
    adminFeeOn.value = AdminFeeOn.sender;
    adminFeeStr.value = '';
  }

  void onChangeType(String val) {
    walletType.value = val;
  }

  void onChangeTransactionType(String val) {
    transactionType.value = val;
    transactionCategory.value = null;
  }

  void onChangeTransactionCategory(String val) {
    transactionCategory.value = val;
  }

  void onChangeFrom(WalletModel val) {
    toWallet.value = null;
    fromWallet.value = val;
  }

  void onChangeTo(WalletModel val) {
    toWallet.value = val;
  }

  void onChangeAdminFeeOn(AdminFeeOn val) {
    adminFeeOn.value = val;
  }

  void trimAdminFee(String val) {
    adminFeeStr.value = val.trim().replaceAll(RegExp(r'[^0-9]'), '');
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

  Future<void> addTransaction() async {
    try {
      if (fromWallet.value == null ||
          amount.text.trim().isEmpty ||
          transactionType.value == null ||
          transactionCategory.value == null) {
        Get.snackbar(
          'Empty field',
          "Please fill all the fields before continuing.",
          margin: EdgeInsets.all(16),
        );
      } else {
        isLoading.value = true;
        TransactionModel transaction = TransactionModel(
          wallet: fromWallet.value,
          amount: double.tryParse(
            amount.text.trim().replaceAll(RegExp(r'[^0-9]'), ''),
          ),
          type: transactionType.value,
          category: transactionCategory.value,
          desc: desc.text.trim().isEmpty ? null : desc.text.trim(),
        );
        await TransactionService.create(transaction);
        Get.back();
        await Future.delayed(Duration(milliseconds: 100));
        Get.snackbar(
          'Success',
          "Transaction added successfully.",
          margin: EdgeInsets.all(16),
        );
        await getAllWallets();
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        "Failed to add transaction: ${e.toString()}",
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
          adminFeeOn: adminFeeOn.value,
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
    } on Exception catch (e) {
      Get.snackbar(
        'Failed',
        e.toString().replaceFirst('Exception: ', ''),
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
        "Wallet deleted successfully.",
        margin: EdgeInsets.all(16),
      );
      await getAllWallets();
    } catch (e) {
      Get.snackbar(
        'Failed',
        "Failed to delete wallet: ${e.toString().replaceFirst('Exception: ', '')}",
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setWalletCache() async {
    await prefs.setString(
      'wallets',
      jsonEncode(wallets.map((e) => e.toJson(isArchive: true)).toList()),
    );
    await prefs.setString('lastUpdated', lastUpdated.value.toIso8601String());
  }

  void getWalletCache() {
    String? temp = prefs.getString('wallets');
    String? lastUpdatedString = prefs.getString('lastUpdated');
    if (lastUpdatedString != null) {
      lastUpdated.value = DateTime.parse(lastUpdatedString);
    }
    totalBalance.value = 0;
    if (temp != null) {
      List<dynamic> json = jsonDecode(temp);
      wallets.value = json.map((e) {
        WalletModel wallet = WalletModel.fromJson(
          Map<String, dynamic>.from(e),
          isArchive: true,
        );
        totalBalance.value += (wallet.balance ?? 0);
        return wallet;
      }).toList();
    } else {
      wallets.value = [];
    }
  }

  Future<void> getAllWallets() async {
    try {
      if (await network.ensureConnection()) {
        if (hasInit.value) {
          Get.snackbar(
            "You're back online",
            "Loading data from database...",
            margin: EdgeInsets.all(16),
          );
        }
        hasInit.value = false;
        totalBalance.value = 0;
        wallets.value = (await WalletService.get()).map((wallet) {
          WalletModel temp = WalletModel.fromJson(wallet);
          totalBalance.value += (temp.balance ?? 0);
          return temp;
        }).toList();
        lastUpdated.value = DateTime.now();
        setWalletCache();
      } else {
        hasInit.value = true;
        getWalletCache();
      }
    } on FirebaseException catch (e) {
      Get.snackbar(
        'Failed',
        "Failed to fetch data: ${e.toString().replaceFirst('Exception: ', '')}",
        margin: EdgeInsets.all(16),
      );
    }
  }
}
