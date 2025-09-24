import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_dropdown.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../controllers/dashboard_controller.dart';

class InputLayout {
  static DashboardController controller = Get.find<DashboardController>();

  static Widget template({
    required Widget child,
    required String title,
    required BuildContext context,
    required Function onSubmit,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      // width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          CustomText.h3(title, context: context),
          child,
          Align(
            alignment: Alignment.centerRight,
            child: CustomButton.primary(
              "Save",
              context: context,
              onPressed: onSubmit,
            ),
          ),
        ],
      ),
    );
  }

  static Widget wallet({required BuildContext context}) {
    controller.resetForm();
    return template(
      title: "Add new wallet",
      context: context,
      onSubmit: controller.createNewWallet,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          CustomTextField.normal(
            controller.walletName,
            context: context,
            label: "Wallet name",
            prefixIcon: Icon(Symbols.abc),
          ),
          CustomTextField.normal(
            controller.initBalance,
            context: context,
            label: "Initial balance",
            isNumOnly: true,
            prefixIcon: Padding(
              padding: EdgeInsets.all(12),
              child: CustomText.normal("Rp", context: context),
            ),
          ),
          CustomDropdown.str(
            "Type",
            controller.type.value,
            controller.typeOptions,
            controller.onChangeType,
          ),
        ],
      ),
    );
  }

  static void showBottomSheet({
    required Widget content,
    required BuildContext context,
  }) {
    controller.isMenuExpanded.value = false;
    Get.bottomSheet(
      content,
      backgroundColor: Theme.of(context).cardColor,
      isScrollControlled: true,
    );
  }
}
