import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/controllers/network_controller.dart';
import '../../../../core/services/auth_service.dart';

class SignUpController extends GetxController {
  late final TextEditingController fullName;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;
  RxBool isObscurePass = true.obs;
  RxBool isObscureConfirmPass = true.obs;
  RxBool isLoading = false.obs;
  NetworkController network = Get.find<NetworkController>();

  @override
  void onInit() {
    super.onInit();
    fullName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    fullName.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  Future<void> signUpWithEmailAndPassword() async {
    try {
      if (await network.ensureConnection()) {
        isLoading.value = true;
        if (email.text.trim().isEmpty || fullName.text.trim().isEmpty) {
          Get.snackbar(
            'All fields are required',
            'Please fill in all the fields before continuing.',
            margin: EdgeInsets.all(16),
          );
          return;
        }
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
          displayName: fullName.text.trim(),
        );
        Get.back(); // navigate on success
        Get.snackbar(
          'Sign up success',
          "Please login to continue.",
          margin: EdgeInsets.all(16),
        );
      }
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
