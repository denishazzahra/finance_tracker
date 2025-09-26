import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/consts/app_const.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_dropdown.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/warning_dialog.dart' show WarningDialog;
import '../../../../data/models/wallet_model.dart';
import '../../controllers/dashboard_controller.dart';

class InputLayout {
  static DashboardController controller = Get.find<DashboardController>();

  static Widget template({
    required Widget child,
    required String title,
    required BuildContext context,
    required Function onSubmit,
    String mode = "wallet",
    Function? onDelete,
    dynamic id,
  }) {
    bool isLight = Get.theme.brightness == Brightness.light;
    Color onSurface = Get.theme.colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.all(16),
      // width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          CustomText.h3(
            title,
            color: isLight ? onSurface : null,
            context: context,
          ),
          child,
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                if (onDelete != null)
                  CustomButton.danger(
                    "Delete",
                    onPressed: () async {
                      bool confirm = await WarningDialog.showConfirmDialog(
                        context: context,
                        title: "Delete Wallet",
                        content: "Are you sure you want to delete this $mode?",
                        confirmText: "Delete",
                        isDanger: true,
                      );
                      if (confirm) {
                        onDelete(id);
                      }
                    },
                    context: context,
                  ),
                CustomButton.primary(
                  "Save",
                  onPressed: onSubmit,
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget wallet({WalletModel? wallet, required BuildContext context}) {
    controller.resetForm();
    if (wallet != null) {
      controller.selectedWallet.value = wallet;
      controller.walletName.text = wallet.name ?? '';
      controller.amount.text = NumberFormat.decimalPattern(
        'id_ID',
      ).format(wallet.balance);
      controller.walletType.value = wallet.type;
    }
    return template(
      title: "${wallet != null ? "Update" : "Add new"} wallet",
      context: context,
      onSubmit: wallet != null
          ? () async {
              bool confirm = await WarningDialog.showConfirmDialog(
                context: context,
                title: "Update Wallet",
                content: "Are you sure you want to update this wallet?",
                confirmText: "Update",
              );
              if (confirm) {
                controller.updateWallet();
              }
            }
          : controller.createNewWallet,
      onDelete: wallet != null ? controller.deleteWallet : null,
      id: wallet?.id,
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
            controller.amount,
            context: context,
            label: "Balance",
            isNumOnly: true,
            prefixIcon: Padding(
              padding: EdgeInsets.all(12),
              child: CustomText.normal("Rp", context: context),
            ),
          ),
          CustomDropdown.str(
            "Type",
            controller.walletType.value,
            walletTypeOptions,
            controller.onChangeType,
          ),
        ],
      ),
    );
  }

  static Widget transfer({required BuildContext context}) {
    controller.resetForm();
    return template(
      title: "Transfer money",
      context: context,
      onSubmit: controller.transferMoney,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          CustomDropdown.obj(
            "From",
            controller.fromWallet.value,
            controller.wallets,
            controller.onChangeFrom,
          ),
          Obx(
            () => CustomDropdown.obj(
              "To",
              controller.toWallet.value,
              controller.wallets
                  .where((e) => e.id != controller.fromWallet.value?.id)
                  .toList(),
              controller.onChangeTo,
            ),
          ),
          CustomTextField.normal(
            controller.amount,
            context: context,
            label: "Amount",
            isNumOnly: true,
            prefixIcon: Padding(
              padding: EdgeInsets.all(12),
              child: CustomText.normal("Rp", context: context),
            ),
          ),
          CustomTextField.normal(
            controller.adminFee,
            context: context,
            label: "Admin Fee (optional)",
            isNumOnly: true,
            prefixIcon: Padding(
              padding: EdgeInsets.all(12),
              child: CustomText.normal("Rp", context: context),
            ),
          ),
        ],
      ),
    );
  }

  static void showBottomSheet({required Widget content}) {
    controller.isMenuExpanded.value = false;
    Get.bottomSheet(
      content,
      backgroundColor: Get.theme.cardColor,
      isScrollControlled: true,
    );
  }
}
