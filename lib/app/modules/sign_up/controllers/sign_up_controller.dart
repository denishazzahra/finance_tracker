import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;
  RxBool isObscurePass = true.obs;
  RxBool isObscureConfirmPass = true.obs;

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
      if (password.text != confirmPassword.text) {
        Get.snackbar(
          'Password is not identical',
          'Please re-enter your password.',
          margin: EdgeInsets.all(16),
        );
      }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          'Sign up failed',
          'The password provided is too weak.',
          margin: EdgeInsets.all(16),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Sign up failed',
          'The account already exists for that email.',
          margin: EdgeInsets.all(16),
        );
      } else {
        Get.snackbar(
          'Sign up failed',
          e.message ?? 'An unknown error occured.',
          margin: EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar('Sign up failed', e.toString(), margin: EdgeInsets.all(16));
    }
  }
}
