import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/consts/app_const.dart';
import '../../../../core/utils/custom_converter.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../data/models/transaction_model.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    Color? chipCol = Theme.of(context).chipTheme.backgroundColor;
    Color? cardCol = Theme.of(context).cardColor;
    return RefreshIndicator(
      onRefresh: controller.initializeData,
      child: Obx(() {
        if (controller.isLoading.value) {
          return Skeletonizer(
            enabled: controller.isLoading.value,
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              separatorBuilder: (context, index) => Divider(color: cardCol),
              itemCount: 3,
              itemBuilder: (context, index) => Row(
                spacing: 16,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: chipCol,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        Row(
                          spacing: 16,
                          children: [
                            Expanded(
                              child: CustomText.normal(
                                'aaaaaaaaaa',
                                isBold: true,
                                context: context,
                              ),
                            ),
                            CustomText.small('aaaaaaaa', context: context),
                          ],
                        ),
                        CustomText.small(
                          'aaaaaaaaaaaaaaaaaaaa',
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (controller.transactions.isEmpty) {
          return Center(
            child: CustomText.normal('No transactions.', context: context),
          );
        }
        return ListView.separated(
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            TransactionModel? transaction = controller.transactions[index];
            IconData icon =
                transactionCategoryMap[controller
                    .transactions[index]
                    ?.category];
            Color bgCol = transactionTypeMap(
              context,
            )[controller.transactions[index]?.type]?['bgCol'];
            Color fgCol = transactionTypeMap(
              context,
            )[controller.transactions[index]?.type]?['fgCol'];

            return Row(
              spacing: 16,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: bgCol,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Center(child: Icon(icon, color: fgCol, size: 20)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 8,
                    children: [
                      Row(
                        spacing: 16,
                        children: [
                          Expanded(
                            child: CustomText.normal(
                              transaction?.category ?? '-',
                              isBold: true,
                              context: context,
                            ),
                          ),
                          CustomText.normal(
                            CustomConverter.doubleToCurrency(
                              transaction?.amount,
                            ),
                            context: context,
                            color: fgCol,
                          ),
                        ],
                      ),
                      CustomText.small(
                        transaction?.desc ?? '-',
                        context: context,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) =>
              Divider(color: Theme.of(context).cardColor),
          itemCount: controller.transactions.length,
        );
      }),
    );
  }
}
