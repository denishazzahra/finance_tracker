import 'package:flutter/material.dart';

import '../../../../../core/utils/custom_converter.dart';
import '../../../../../core/widgets/custom_text.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  const BalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    Color onPrimary = Theme.of(context).colorScheme.onPrimary;
    Color card = Theme.of(context).cardColor;
    Color onCard = Theme.of(context).colorScheme.onSurface;
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return Card(
      elevation: 1,
      color: isLight ? primary : card,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            CustomText.small(
              "Balance",
              context: context,
              color: isLight ? onPrimary : onCard,
            ),
            CustomText.h3(
              CustomConverter.doubleToCurrency(balance),
              context: context,
              color: isLight ? onPrimary : primary,
            ),
          ],
        ),
      ),
    );
  }
}
