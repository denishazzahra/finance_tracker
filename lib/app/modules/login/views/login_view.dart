import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_divider.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    Color? onSurface = Theme.of(context).colorScheme.onSurface;
    Color? primary = Theme.of(context).primaryColor;
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
                Image.asset('assets/images/login.png', height: 196),
                SizedBox(height: 12),
                CustomText.h1(
                  "Login",
                  context: context,
                  color: isLight ? onSurface : null,
                ),
                SizedBox(height: 12),
                CustomTextField.auth(
                  controller.email,
                  label: 'Email',
                  context: context,
                  prefixIcon: Icon(
                    Symbols.mail,
                    color: isLight ? onSurface : primary,
                  ),
                ),
                Obx(
                  () => CustomTextField.auth(
                    controller.password,
                    label: 'Password',
                    context: context,
                    isObscure: controller.isObscure.value,
                    prefixIcon: Icon(
                      Symbols.lock,
                      color: isLight ? onSurface : primary,
                    ),
                    suffixIcon: CustomButton.redEye(
                      controller.isObscure,
                      context: context,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: isLight ? onSurface : primary,
                      ),
                    );
                  }
                  return CustomButton.primary(
                    "Login",
                    context: context,
                    onPressed: controller.login,
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText.small(
                      "Don't have an account yet? ",
                      context: context,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed('/sign-up'),
                      child: CustomText.small(
                        "Sign Up",
                        context: context,
                        isBold: true,
                        color: isLight ? Colors.orange.shade700 : primary,
                      ),
                    ),
                  ],
                ),
                CustomDivider.withText('or', context: context),
                CustomButton.google(
                  "Login with Google",
                  context: context,
                  onPressed: controller.loginWithGoogle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
