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
    bool isLight = Theme.of(context).brightness == Brightness.light;
    Color? chipCol = Theme.of(context).chipTheme.backgroundColor;
    Color? onSurface = Theme.of(context).colorScheme.onSurface;
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
            TransactionModel? currTransaction = controller.transactions[index];
            TransactionModel? prevTransaction = index == 0
                ? null
                : controller.transactions[index - 1];
            IconData icon = transactionCategoryMap[currTransaction?.category];
            Color bgCol = transactionTypeMap(
              context,
            )[currTransaction?.type]?['bgCol'];
            Color fgCol = transactionTypeMap(
              context,
            )[currTransaction?.type]?['fgCol'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                if (!controller.checkSameDay(
                  curr: currTransaction?.dateTime,
                  prev: prevTransaction?.dateTime,
                  index: index,
                )) ...[
                  if (index != 0) SizedBox(),
                  CustomText.h3(
                    CustomConverter.dateToDisplay(currTransaction?.dateTime),
                    context: context,
                    color: isLight ? onSurface : null,
                  ),
                ],
                Row(
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
                                  currTransaction?.category ?? '-',
                                  isBold: true,
                                  context: context,
                                ),
                              ),
                              CustomText.normal(
                                CustomConverter.doubleToCurrency(
                                  currTransaction?.amount,
                                ),
                                context: context,
                                color: fgCol,
                              ),
                            ],
                          ),
                          CustomText.small(
                            currTransaction?.desc ?? '-',
                            context: context,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => Divider(color: chipCol),
          itemCount: controller.transactions.length,
        );
      }),
    );
  }
}
