import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class WarningDialog {
  static Future<bool> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmText,
    bool isDanger = false,
  }) async {
    bool isLight = Get.theme.brightness == Brightness.light;
    final result = await Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        title: CustomText.h3(
          title,
          color: isLight ? Get.theme.colorScheme.onSurface : null,
          context: context,
        ),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        content: CustomText.normal(content, context: context),
        contentPadding: const EdgeInsets.all(20),
        actions: [
          CustomButton.text(
            'Cancel',
            onPressed: () => Get.back(result: false),
            context: context,
          ),
          isDanger
              ? CustomButton.danger(
                  confirmText,
                  onPressed: () => Get.back(result: true),
                  context: context,
                )
              : CustomButton.primary(
                  confirmText,
                  onPressed: () => Get.back(result: true),
                  context: context,
                ),
        ],
      ),
    );

    return result ?? false;
  }
}
