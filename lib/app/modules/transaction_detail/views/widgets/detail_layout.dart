import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/consts/app_const.dart';
import '../../../../../core/utils/custom_converter.dart';
import '../../../../../core/widgets/custom_icon.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../data/models/transaction_model.dart';
import '../../../../data/models/transfer_model.dart';

class DetailLayout extends StatelessWidget {
  final Function onRefresh;
  final TransactionModel? transaction;
  const DetailLayout({
    super.key,
    required this.onRefresh,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    Color? chipCol = Theme.of(context).chipTheme.backgroundColor;
    Color? onSurface = Theme.of(context).colorScheme.onSurface;
    return RefreshIndicator(
      onRefresh: () => onRefresh(),
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: CustomIcon.display(
              bgCol: transactionTypeMap(context)[transaction?.type]?['bgCol'],
              iconCol: transactionTypeMap(context)[transaction?.type]?['fgCol'],
              icon: transactionCategoryMap[transaction?.category]?['icon'],
              iconSize: 32,
              width: 48,
            ),
          ),
          SizedBox(height: 16),
          CustomText.h2(
            CustomConverter.doubleToCurrency(transaction?.amount),
            context: context,
            isCenter: true,
            color: isLight ? onSurface : null,
          ),
          SizedBox(height: 16),
          Divider(color: chipCol),
          SizedBox(height: 8),
          CustomText.normal(
            'Transaction details',
            context: context,
            isBold: true,
          ),
          SizedBox(height: 16),
          detailRow(key: 'Type', value: transaction!.type!, context: context),
          SizedBox(height: 16),
          detailRow(
            key: 'Category',
            value: transaction!.category!,
            context: context,
          ),
          SizedBox(height: 16),
          transaction?.transfer == null
              ? detailRow(
                  key: 'Wallet',
                  value: transaction!.wallet!.name!,
                  context: context,
                )
              : detailRow(
                  key: 'From',
                  value: transaction!.transfer!.from.name!,
                  context: context,
                ),

          if (transaction?.transfer != null) SizedBox(height: 16),
          if (transaction?.transfer != null)
            detailRow(
              key: 'To',
              value: transaction!.transfer!.to.name!,
              context: context,
            ),
          if (transaction?.transfer != null) SizedBox(height: 16),
          if (transaction?.transfer != null)
            detailRow(
              key: 'Transfer Amount',
              value: CustomConverter.doubleToCurrency(
                transaction?.transfer?.amount,
              ),
              context: context,
            ),
          if (transaction?.transfer != null) SizedBox(height: 16),
          if (transaction?.transfer != null)
            detailRow(
              key: 'Admin Fee',
              value: CustomConverter.doubleToCurrency(
                transaction?.transfer?.adminFee,
              ),
              context: context,
            ),
          if (transaction?.transfer != null) SizedBox(height: 16),
          if (transaction?.transfer != null)
            detailRow(
              key: 'Admin Fee On',
              value: transaction!.transfer!.adminFeeOn == AdminFeeOn.sender
                  ? transaction!.transfer!.from.name!
                  : transaction!.transfer!.to.name!,
              context: context,
            ),
          SizedBox(height: 16),
          detailRow(
            key: 'Description',
            value: (transaction?.desc ?? '-'),
            context: context,
          ),
          SizedBox(height: 16),
          detailRow(
            key: 'Date',
            value: CustomConverter.dateToDisplay(transaction?.dateTime),
            context: context,
          ),
          SizedBox(height: 16),
          detailRow(
            key: 'Time',
            value: CustomConverter.timeToDisplay(transaction?.dateTime),
            context: context,
          ),
          SizedBox(height: 16),
          detailRow(
            key: 'Transaction ID',
            value: transaction!.id!,
            context: context,
            isCopyAllowed: true,
          ),
          SizedBox(height: 8),
          if (transaction?.transfer != null) Divider(color: chipCol),
          if (transaction?.transfer != null) SizedBox(height: 8),
          if (transaction?.transfer != null)
            detailRow(
              key: 'Subtotal (${transaction!.transfer!.from.name})',
              value: CustomConverter.doubleToCurrency(
                -transaction!.transfer!.amount -
                    (transaction?.transfer?.adminFeeOn == AdminFeeOn.sender
                            ? 1
                            : 0) *
                        (transaction!.transfer!.adminFee),
              ),
              context: context,
            ),
          if (transaction?.transfer != null) SizedBox(height: 16),
          if (transaction?.transfer != null)
            detailRow(
              key: 'Subtotal (${transaction!.transfer!.to.name})',
              value: CustomConverter.doubleToCurrency(
                transaction!.transfer!.amount -
                    (transaction?.transfer?.adminFeeOn == AdminFeeOn.recipient
                            ? 1
                            : 0) *
                        (transaction!.transfer!.adminFee),
              ),
              context: context,
            ),
          if (transaction?.transfer != null) SizedBox(height: 8),
          Divider(color: chipCol),
          SizedBox(height: 8),
          detailRow(
            key: 'Total',
            value: CustomConverter.doubleToCurrency(transaction?.amount),
            context: context,
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget detailRow({
    required String key,
    required String value,
    required BuildContext context,
    bool isCopyAllowed = false,
    bool isBold = false,
  }) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    Color? primary = Theme.of(context).colorScheme.primary;
    return Row(
      crossAxisAlignment: isCopyAllowed
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        CustomText.normal(key, context: context, isBold: isBold),
        SizedBox(width: 24),
        // Spacer(),
        Expanded(
          child: CustomText.normal(
            value,
            context: context,
            isRight: true,
            isBold: isBold,
          ),
        ),
        if (isCopyAllowed) SizedBox(width: 8),
        if (isCopyAllowed)
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: value));
              Get.snackbar(
                'Copied!',
                'Text copied to clipboard.',
                margin: EdgeInsets.all(16),
              );
            },
            child: Icon(
              Symbols.content_copy,
              color: isLight ? Colors.orange.shade700 : primary,
              size: 16,
            ),
          ),
      ],
    );
  }
}
