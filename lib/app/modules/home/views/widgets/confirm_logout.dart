import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/theme/finance_color.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';

class ConfirmLogout extends StatelessWidget {
  final Function logout;
  const ConfirmLogout({super.key, required this.logout});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      title: CustomText.h3('Confirm Logout', context: context),
      titlePadding: EdgeInsets.all(20),
      content: CustomText.normal(
        "Are you sure you want to logout?",
        context: context,
      ),
      contentPadding: EdgeInsets.all(20),
      actions: [
        CustomButton.text("Cancel", context: context, onPressed: Get.back),
        CustomButton.text(
          "Logout",
          context: context,
          onPressed: logout,
          color: Theme.of(context).extension<FinanceColors>()?.onExpense,
        ),
      ],
    );
  }
}
