import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../controllers/insight_controller.dart';
import 'widgets/summary_chart.dart';

class InsightView extends GetView<InsightController> {
  const InsightView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.getTransactionCache(date: controller.date.value);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          kToolbarHeight + kTextTabBarHeight,
        ),
        child: Obx(
          () => CustomAppBar.date(
            monthDiff: controller.monthDiff.value,
            context: context,
            changeMonth: controller.changeMonth,
            tabController: controller.tabController,
            tabs: ['All', 'Income', 'Expense'],
          ),
        ),
      ),

      body: TabBarView(
        controller: controller.tabController,
        children: [
          Obx(
            () => summaryChart(
              transactions: controller.transactions,
              isOverall: true,
              context: context,
              onRefresh: controller.initializeData,
            ),
          ),
          Obx(
            () => summaryChart(
              transactions: controller.transactions,
              isOverall: false,
              type: 'Income',
              context: context,
              onRefresh: controller.initializeData,
            ),
          ),
          Obx(
            () => summaryChart(
              transactions: controller.transactions,
              isOverall: false,
              type: 'Expense',
              context: context,
              onRefresh: controller.initializeData,
            ),
          ),
        ],
      ),
    );
  }
}
