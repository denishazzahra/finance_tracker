import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/custom_converter.dart';
import '../../../../../core/widgets/custom_text.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final String lastUpdated;
  final bool isLoading;
  const BalanceCard({
    super.key,
    required this.balance,
    required this.lastUpdated,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    Color onPrimary = Theme.of(context).colorScheme.onPrimary;
    Color card = Theme.of(context).cardColor;
    return Card(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            colors: [primary, card],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.5, 0.9],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            CustomText.normal("Balance", color: onPrimary, context: context),
            Skeletonizer(
              enabled: isLoading,
              child: isLoading
                  ? CustomText.h1(
                      'aaaaaaaa',
                      color: onPrimary,
                      context: context,
                    )
                  : CustomText.h1(
                      CustomConverter.doubleToCurrency(balance),
                      color: onPrimary,
                      context: context,
                    ),
            ),
            CustomText.small(
              'Last updated: $lastUpdated',
              context: context,
              color: onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
