import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../core/consts/app_const.dart';
import '../../../../../core/theme/finance_color.dart';
import '../../../../../core/utils/custom_converter.dart';
import '../../../../../core/widgets/custom_icon.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../data/models/transaction_model.dart';

Widget summaryChart({
  required List<TransactionModel> transactions,
  bool isOverall = true,
  String? type,
  required BuildContext context,
  required Function onRefresh,
}) {
  bool isLight = Theme.of(context).brightness == Brightness.light;
  double width = MediaQuery.of(context).size.width;
  double centerSpaceRadius = 40;
  Color? chipCol = Theme.of(context).chipTheme.backgroundColor;
  Color? onIncome = Theme.of(context).extension<FinanceColors>()?.onIncome;
  Color? onExpense = Theme.of(context).extension<FinanceColors>()?.onExpense;
  if (isOverall) {
    if (transactions.isEmpty) {
      return noTransaction(context: context, onRefresh: onRefresh);
    }
    double overallTotal = 0;
    Map<String, double> totals = {
      for (String type in transactionTypeOptions) type: 0,
    };
    for (TransactionModel transaction in transactions) {
      totals[transaction.type!] =
          (totals[transaction.type] ?? 0) + transaction.amount!.abs();
      overallTotal += transaction.amount!.abs();
    }
    return RefreshIndicator(
      onRefresh: () => onRefresh(),
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                sectionsSpace: 4,
                centerSpaceRadius: centerSpaceRadius,
                sections: totals.entries
                    .map(
                      (entry) => PieChartSectionData(
                        value: entry.value,
                        title:
                            '${(100 * entry.value / overallTotal).toStringAsFixed(2)}%',
                        color: transactionTypeMap(
                          context,
                        )[entry.key]![isLight ? 'fgCol' : 'bgCol'],
                        titleStyle: TextStyle(
                          color: transactionTypeMap(
                            context,
                          )[entry.key]![isLight ? 'bgCol' : 'fgCol'],
                          fontWeight: FontWeight.w600,
                        ),
                        radius: width / 2 - (centerSpaceRadius + 32),
                        badgeWidget: CustomIcon.display(
                          bgCol: transactionTypeMap(
                            context,
                          )[entry.key]![isLight ? 'bgCol' : 'fgCol'],
                          iconCol: transactionTypeMap(
                            context,
                          )[entry.key]![isLight ? 'fgCol' : 'bgCol'],
                          icon: transactionTypeMap(context)[entry.key]!['icon'],
                          isCircle: true,
                          iconSize: 32,
                        ),
                        badgePositionPercentageOffset: 1,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SizedBox(height: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:
                totals.entries
                    .map((entry) {
                      IconData icon = transactionTypeMap(
                        context,
                      )[entry.key]?['icon'];
                      Color bgCol = transactionTypeMap(
                        context,
                      )[entry.key]?['bgCol'];
                      Color fgCol = transactionTypeMap(
                        context,
                      )[entry.key]?['fgCol'];
                      return [
                        Row(
                          spacing: 16,
                          children: [
                            CustomIcon.display(
                              bgCol: isLight ? bgCol : fgCol,
                              iconCol: isLight ? fgCol : bgCol,
                              icon: icon,
                            ),

                            Expanded(
                              child: CustomText.normal(
                                entry.key,
                                isBold: true,
                                context: context,
                              ),
                            ),
                            CustomText.normal(
                              CustomConverter.doubleToCurrency(
                                entry.key == 'Income'
                                    ? entry.value
                                    : -(entry.value),
                              ),
                              context: context,
                              color: entry.key == 'Income'
                                  ? onIncome
                                  : onExpense,
                            ),
                          ],
                        ),
                        Divider(color: chipCol),
                      ];
                    })
                    .expand(
                      (element) => element,
                    ) // Flattens the list of [Item, Divider]
                    .toList()
                  // Remove the last divider (the last element in the flattened list)
                  ..removeLast(),
          ),
        ],
      ),
    );
  } else {
    List<TransactionModel> filteredTrans = transactions
        .where((e) => e.type == type)
        .toList();
    if (filteredTrans.isEmpty) {
      return noTransaction(context: context, onRefresh: onRefresh);
    }
    double overallTotal = 0;
    Map<String, double> totals = {};
    for (TransactionModel transaction in filteredTrans) {
      totals[transaction.category!] =
          (totals[transaction.category] ?? 0) + transaction.amount!.abs();
      overallTotal += transaction.amount!.abs();
    }

    return RefreshIndicator(
      onRefresh: () => onRefresh(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: centerSpaceRadius,
                  sections: totals.entries
                      .map(
                        (entry) => PieChartSectionData(
                          value: entry.value,
                          title:
                              '${(100 * entry.value / overallTotal).toStringAsFixed(2)}%',
                          color: transactionCategoryMap[entry.key]!['bgCol'],
                          titleStyle: TextStyle(
                            color: transactionCategoryMap[entry.key]!['fgCol'],
                            fontWeight: FontWeight.w600,
                          ),
                          badgeWidget: CustomIcon.display(
                            bgCol: transactionCategoryMap[entry.key]!['fgCol'],
                            iconCol:
                                transactionCategoryMap[entry.key]!['bgCol'],
                            icon: transactionCategoryMap[entry.key]!['icon'],
                            isCircle: true,
                            iconSize: 32,
                          ),
                          radius: width / 2 - (centerSpaceRadius + 32),
                          badgePositionPercentageOffset: 1,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:
                totals.entries
                    .map((entry) {
                      IconData icon =
                          transactionCategoryMap[entry.key]?['icon'];
                      Color bgCol = transactionCategoryMap[entry.key]?['bgCol'];
                      Color fgCol = transactionCategoryMap[entry.key]?['fgCol'];
                      return [
                        Row(
                          spacing: 16,
                          children: [
                            CustomIcon.display(
                              bgCol: bgCol,
                              iconCol: fgCol,
                              icon: icon,
                            ),
                            Expanded(
                              child: CustomText.normal(
                                entry.key,
                                isBold: true,
                                context: context,
                              ),
                            ),
                            CustomText.normal(
                              CustomConverter.doubleToCurrency(
                                type == 'Income' ? entry.value : -(entry.value),
                              ),
                              context: context,
                              color: type == 'Income' ? onIncome : onExpense,
                            ),
                          ],
                        ),
                        Divider(color: chipCol),
                      ];
                    })
                    .expand(
                      (element) => element,
                    ) // Flattens the list of [Item, Divider]
                    .toList()
                  // Remove the last divider (the last element in the flattened list)
                  ..removeLast(),
          ),
        ],
      ),
    );
  }
}

Widget noTransaction({
  required BuildContext context,
  required Function onRefresh,
}) {
  return LayoutBuilder(
    builder: (context, constraints) => RefreshIndicator(
      onRefresh: () => onRefresh(),
      child: ListView(
        children: [
          SizedBox(
            height: constraints.maxHeight,
            child: Center(
              child: CustomText.normal('No transaction.', context: context),
            ),
          ),
        ],
      ),
    ),
  );
}
