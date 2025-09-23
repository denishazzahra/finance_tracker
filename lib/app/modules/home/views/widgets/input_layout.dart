import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class InputLayout {
  static wallet({required BuildContext context}) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomText.h3('Add New Wallet', context: context),
            const SizedBox(height: 12),
            // CustomTextField.box(controller: context: context, label: "Nama Gudang"),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              // child: CustomButton.primary("Save", 90, () {}
              //   ),
            ),
          ],
        ),
      ),
    );
  }
}
