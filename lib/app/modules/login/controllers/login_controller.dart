import 'package:finance_tracker/core/controllers/network_controller.dart'
    show NetworkController;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';

class LoginController extends GetxController {
  late final TextEditingController email;
  late final TextEditingController password;
  RxBool isObscure = true.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingGoogle = false.obs;
  NetworkController network = Get.find<NetworkController>();

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    email.dispose();
    password.dispose();
  }

  Future<void> login() async {
    try {
      if (await network.ensureConnection()) {
        isLoading.value = true;
        final User? user = await AuthService.loginWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text,
        );
        Get.offAllNamed('/home'); // navigate on success
        Get.snackbar(
          'Login success',
          "Welcome, ${user?.displayName ?? "new user!"}",
          margin: EdgeInsets.all(16),
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Login failed',
        e.message ?? 'Unknown error',
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      if (await network.ensureConnection()) {
        isLoadingGoogle.value = true;
        User? user = await AuthService.loginWithGoogle();
        Get.offAllNamed('/home'); // navigate on success
        Get.snackbar(
          'Login success',
          "Welcome, ${user?.displayName ?? "new user!"}",
          margin: EdgeInsets.all(16),
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Login failed',
        e.message ?? 'Unknown error',
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoadingGoogle.value = false;
    }
  }
}
