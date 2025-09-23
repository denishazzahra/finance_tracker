import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';

class LoginController extends GetxController {
  late final TextEditingController email;
  late final TextEditingController password;
  RxBool isObscure = true.obs;
  RxBool isLoading = false.obs;

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
    isLoading.value = true;
    try {
      await AuthService.loginWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text,
      );
      Get.offAllNamed('/home'); // navigate on success
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
}
