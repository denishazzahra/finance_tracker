import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late final TextEditingController email;
  late final TextEditingController password;
  RxBool isObscure = true.obs;

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

  void login() {}
}
