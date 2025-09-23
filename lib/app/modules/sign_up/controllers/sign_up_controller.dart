import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';

class SignUpController extends GetxController {
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;
  RxBool isObscurePass = true.obs;
  RxBool isObscureConfirmPass = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  Future<void> signUpWithEmailAndPassword() async {
    try {
      isLoading.value = true;
      if (password.text != confirmPassword.text) {
        Get.snackbar(
          'Password is not identical',
          'Please re-enter your password.',
          margin: EdgeInsets.all(16),
        );
        return;
      }
      await AuthService.signUpWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text,
      );
      Get.offAllNamed('/home'); // navigate on success
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = e.message ?? 'An unknown error occurred.';
      }
      Get.snackbar('Sign up failed', message, margin: EdgeInsets.all(16));
    } catch (e) {
      Get.snackbar('Sign up failed', e.toString(), margin: EdgeInsets.all(16));
    } finally {
      isLoading.value = false;
    }
  }
}
