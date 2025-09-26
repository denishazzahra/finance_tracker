import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/custom_converter.dart';
import '../controllers/dashboard_controller.dart';
import 'widgets/balance_card.dart';
import 'widgets/input_layout.dart';
import 'widgets/wallets_list_card.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 16,
          children: [
            if (controller.isMenuExpanded.value) ...[
              FloatingActionButton(
                onPressed: () => InputLayout.showBottomSheet(
                  content: InputLayout.wallet(context: context),
                ),
                tooltip: "Add new wallet",
                shape: CircleBorder(),
                mini: true,
                child: Icon(Symbols.account_balance_wallet),
              ),
              FloatingActionButton(
                onPressed: () => InputLayout.showBottomSheet(
                  content: InputLayout.transfer(context: context),
                ),
                tooltip: "Transfer money",
                shape: CircleBorder(),
                mini: true,
                child: Icon(Symbols.swap_horiz),
              ),
              FloatingActionButton(
                onPressed: () => InputLayout.showBottomSheet(
                  content: InputLayout.transaction(context: context),
                ),
                tooltip: "Insert cashflow",
                shape: CircleBorder(),
                mini: true,
                child: Icon(Symbols.attach_money),
              ),
            ],
            FloatingActionButton(
              onPressed: () => controller.toggleMenu(),
              shape: CircleBorder(),
              tooltip: "Action",
              child: Icon(
                controller.isMenuExpanded.value ? Symbols.close : Symbols.add,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.initializeData(),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Obx(
              () => BalanceCard(
                balance: controller.totalBalance.value,
                lastUpdated: CustomConverter.datetimeToDisplay(
                  controller.lastUpdated.value,
                ),
                isLoading: controller.isLoading.value,
              ),
            ),
            SizedBox(height: 16),
            WalletsListCard(),
          ],
        ),
      ),
    );
  }
}
