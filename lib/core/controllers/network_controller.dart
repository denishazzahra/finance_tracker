import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  var isOnline = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkInitialConnection() async {
    final results = await _connectivity.checkConnectivity();
    _updateConnectionStatus(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final connected = results.any((r) => r != ConnectivityResult.none);
    isOnline.value = connected;
  }

  Future<bool> ensureConnection() async {
    if (!isOnline.value) {
      Get.snackbar(
        'No Internet Connection',
        'Please check your network and try again.',
        margin: const EdgeInsets.all(16),
      );
      return false;
    }
    return true;
  }
}
