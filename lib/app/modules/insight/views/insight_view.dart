import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart' show Symbols;

import '../../../../core/services/auth_service.dart';
// import '../../../../core/theme/finance_color.dart';
import '../../../../core/utils/custom_converter.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../controllers/insight_controller.dart';
import 'widgets/summary_chart.dart';

class InsightView extends GetView<InsightController> {
  const InsightView({super.key});
  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    Color? chipCol = Theme.of(context).chipTheme.backgroundColor;
    Color? onPrimary = Theme.of(context).colorScheme.onPrimary;
    // Color? onDanger = Theme.of(context).extension<FinanceColors>()?.onExpense;
    return Scaffold(
      appBar: AppBar(
        leading: Obx(
          () => Visibility(
            visible:
                CustomConverter.nMonthDiff(
                  controller.monthDiff.value - 1,
                ).isAfter(AuthService.getCreationTime()) ||
                CustomConverter.nMonthDiff(
                  controller.monthDiff.value - 1,
                ).isAtSameMomentAs(AuthService.getCreationTime()),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: CustomButton.icon(
              Symbols.arrow_back_ios,
              context: context,
              onPressed: () => controller.changeMonth(-1),
            ),
          ),
        ),
        title: Obx(
          () => CustomText.h3(
            DateFormat(
              'MMMM yyyy',
            ).format(CustomConverter.nMonthDiff(controller.monthDiff.value)),
            context: context,
            color: isLight ? onPrimary : null,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => Visibility(
              visible: controller.monthDiff.value + 1 < 1,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: CustomButton.icon(
                Symbols.arrow_forward_ios,
                context: context,
                onPressed: () => controller.changeMonth(1),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: controller.tabController,
          dividerColor: chipCol,
          tabs: [
            Tab(child: CustomText.small('All', context: context)),
            Tab(child: CustomText.small('Income', context: context)),
            Tab(child: CustomText.small('Expense', context: context)),
          ],
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
            ),
          ),
          Obx(
            () => summaryChart(
              transactions: controller.transactions,
              isOverall: false,
              type: 'Income',
              context: context,
            ),
          ),
          Obx(
            () => summaryChart(
              transactions: controller.transactions,
              isOverall: false,
              type: 'Expense',
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
