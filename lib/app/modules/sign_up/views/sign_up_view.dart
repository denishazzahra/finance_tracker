import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                Image.asset('assets/images/signup.png', height: 196),
                SizedBox(height: 12),
                CustomText.h1("Sign Up", context: context),
                SizedBox(height: 12),
                CustomTextField.auth(
                  controller.fullName,
                  label: 'Full Name',
                  context: context,
                  prefixIcon: Icon(
                    Symbols.person,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                CustomTextField.auth(
                  controller.email,
                  label: 'Email',
                  context: context,
                  prefixIcon: Icon(
                    Symbols.mail,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Obx(
                  () => CustomTextField.auth(
                    controller.password,
                    label: 'Password',
                    context: context,
                    isObscure: controller.isObscurePass.value,
                    prefixIcon: Icon(
                      Symbols.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                    suffixIcon: CustomButton.redEye(
                      controller.isObscurePass,
                      context: context,
                    ),
                  ),
                ),
                Obx(
                  () => CustomTextField.auth(
                    controller.confirmPassword,
                    label: 'Confirm Password',
                    context: context,
                    isObscure: controller.isObscureConfirmPass.value,
                    prefixIcon: Icon(
                      Symbols.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                    suffixIcon: CustomButton.redEye(
                      controller.isObscureConfirmPass,
                      context: context,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                CustomButton.primary(
                  "Sign Up",
                  context: context,
                  onPressed: controller.signUpWithEmailAndPassword,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText.small(
                      "Already have an account? ",
                      context: context,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: CustomText.small(
                        "Login",
                        context: context,
                        isBold: true,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
