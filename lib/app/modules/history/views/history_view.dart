import 'package:finance_tracker/app/modules/history/views/widget/history_list.dart';
import 'package:finance_tracker/app/modules/history/views/widget/history_skeleton.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.initializeData();
    return Obx(() {
      if (controller.isLoading.value) {
        return HistorySkeleton();
      }
      return HistoryList(
        transactions: controller.transactions,
        checkSameDay: controller.checkSameDay,
        onDelete: controller.deleteTransaction,
        resetBalance: controller.resetBalance,
        monthDiff: controller.monthDiff.value,
        changeMonth: controller.changeMonth,
        onRefresh: controller.initializeData,
      );
    });
  }
}
