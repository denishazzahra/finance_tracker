import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../controllers/transaction_detail_controller.dart';
import 'widgets/detail_layout.dart';

class TransactionDetailView extends GetView<TransactionDetailController> {
  const TransactionDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.initializeData();
    Color? onSurface = Theme.of(context).colorScheme.onSurface;
    return Scaffold(
      appBar: AppBar(
        leading: CustomButton.icon(
          Symbols.close,
          context: context,
          onPressed: () => Get.back(),
          color: onSurface,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.transaction.value != null) {
          return DetailLayout(
            transaction: controller.transaction.value,
            onRefresh: controller.initializeData,
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  CustomText.normal(
                    "You are offline. Make sure you are connected to the internet and try again.",
                    context: context,
                    isCenter: true,
                  ),
                  CustomButton.primary(
                    "Refresh",
                    context: context,
                    icon: Symbols.refresh,
                    onPressed: controller.initializeData,
                    isCompact: true,
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
