import 'package:finance_tracker/app/modules/history/views/widget/history_list.dart';
import 'package:finance_tracker/app/modules/history/views/widget/history_skeleton.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/widgets/custom_text.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    // controller.initializeData();
    return LayoutBuilder(
      builder: (context, constraint) {
        double maxHeight = constraint.maxHeight;
        return RefreshIndicator(
          onRefresh: controller.initializeData,
          child: Obx(() {
            if (controller.isLoading.value) {
              return HistorySkeleton();
            } else if (controller.transactions.isEmpty) {
              return ListView(
                children: [
                  SizedBox(
                    height: maxHeight,
                    child: Center(
                      child: CustomText.normal(
                        'No transactions.',
                        context: context,
                      ),
                    ),
                  ),
                ],
              );
            }
            return HistoryList(
              transactions: controller.transactions,
              checkSameDay: controller.checkSameDay,
              onDelete: controller.deleteTransaction,
              resetBalance: controller.resetBalance,
            );
          }),
        );
      },
    );
  }
}
