import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/consts/app_const.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../core/theme/finance_color.dart';
import '../../../../../core/utils/custom_converter.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/warning_dialog.dart';
import '../../../../data/models/transaction_model.dart';

class HistoryList extends StatelessWidget {
  final List<TransactionModel> transactions;
  final RxBool resetBalance;
  final int monthDiff;
  final Function changeMonth, onRefresh, checkSameDay, onDelete;
  const HistoryList({
    super.key,
    required this.transactions,
    required this.checkSameDay,
    required this.onDelete,
    required this.resetBalance,
    required this.monthDiff,
    required this.changeMonth,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    Color? chipCol = Theme.of(context).chipTheme.backgroundColor;
    Color? onPrimary = Theme.of(context).colorScheme.onPrimary;
    Color? onDanger = Theme.of(context).extension<FinanceColors>()?.onExpense;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible:
                  CustomConverter.nMonthDiff(
                    monthDiff - 1,
                  ).isAfter(AuthService.getCreationTime()) ||
                  CustomConverter.nMonthDiff(
                    monthDiff - 1,
                  ).isAtSameMomentAs(AuthService.getCreationTime()),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: CustomButton.icon(
                Symbols.arrow_back_ios,
                context: context,
                onPressed: () => changeMonth(-1),
              ),
            ),
            CustomText.h3(
              DateFormat(
                'MMMM yyyy',
              ).format(CustomConverter.nMonthDiff(monthDiff)),
              context: context,
              color: isLight ? onPrimary : null,
            ),
            Visibility(
              visible: monthDiff + 1 < 1,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: CustomButton.icon(
                Symbols.arrow_forward_ios,
                context: context,
                onPressed: () => changeMonth(1),
              ),
            ),
          ],
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraint) {
              double maxHeight = constraint.maxHeight;
              return RefreshIndicator(
                onRefresh: () => onRefresh(),
                child: Obx(() {
                  if (transactions.isEmpty) {
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
                  } else {
                    return ListView.separated(
                      padding: EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        TransactionModel? currTransaction = transactions[index];
                        TransactionModel? prevTransaction = index == 0
                            ? null
                            : transactions[index - 1];
                        IconData icon =
                            transactionCategoryMap[currTransaction
                                .category]!['icon'];
                        Color bgCol = transactionTypeMap(
                          context,
                        )[currTransaction.type]?['bgCol'];
                        Color fgCol = transactionTypeMap(
                          context,
                        )[currTransaction.type]?['fgCol'];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 16,
                          children: [
                            if (!checkSameDay(
                              curr: currTransaction.dateTime,
                              prev: prevTransaction?.dateTime,
                              index: index,
                            )) ...[
                              if (index != 0) SizedBox(),
                              CustomText.normal(
                                CustomConverter.dateToDisplay(
                                  currTransaction.dateTime,
                                ),
                                context: context,
                                color: isLight ? onPrimary : null,
                                isBold: true,
                              ),
                            ],
                            Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.startToEnd,
                              background: Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Align(
                                  alignment: AlignmentGeometry.centerLeft,
                                  child: Icon(Symbols.delete, color: onDanger),
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                return await WarningDialog.showConfirmDialog(
                                  title: "Delete Transaction",
                                  confirmText: "Delete",
                                  context: context,
                                  content:
                                      "Are you sure you want to delete this transaction?",
                                  isDanger: true,
                                  checkBox: resetBalance,
                                  checkBoxLabel:
                                      "Apply change to wallet balance",
                                );
                              },
                              onDismissed: (direction) =>
                                  onDelete(currTransaction),
                              child: Row(
                                spacing: 16,
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: bgCol,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(icon, color: fgCol, size: 24),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      spacing: 8,
                                      children: [
                                        Row(
                                          spacing: 16,
                                          children: [
                                            Expanded(
                                              child: CustomText.normal(
                                                currTransaction.category ??
                                                    'Unknown',
                                                isBold: true,
                                                context: context,
                                              ),
                                            ),
                                            CustomText.normal(
                                              CustomConverter.doubleToCurrency(
                                                currTransaction.amount,
                                              ),
                                              context: context,
                                              color: fgCol,
                                            ),
                                          ],
                                        ),
                                        // if (currTransaction.desc != null)
                                        CustomText.small(
                                          currTransaction.desc ?? '-',
                                          context: context,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          Divider(color: chipCol),
                      itemCount: transactions.length,
                    );
                  }
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
