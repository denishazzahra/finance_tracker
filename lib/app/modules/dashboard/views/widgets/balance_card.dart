import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/utils/custom_converter.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../controllers/dashboard_controller.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final String lastUpdated;
  final bool isLoading;
  final bool isObscure;
  const BalanceCard({
    super.key,
    required this.balance,
    required this.lastUpdated,
    required this.isLoading,
    required this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.find<DashboardController>();
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
            Row(
              spacing: 16,
              children: [
                Skeletonizer(
                  enabled: isLoading,
                  child: isLoading
                      ? CustomText.h1(
                          'aaaaaaaa',
                          color: onPrimary,
                          context: context,
                        )
                      : CustomText.h1(
                          isObscure
                              ? "Rp••••••••"
                              : CustomConverter.doubleToCurrency(balance),
                          color: onPrimary,
                          context: context,
                        ),
                ),
                Obx(
                  () => CustomButton.redEye(
                    controller.isObscure,
                    context: context,
                    color: onPrimary
                  ),
                ),
              ],
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
