import 'package:finance_tracker/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/theme/finance_color.dart';
import '../../../../../core/utils/custom_converter.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'input_layout.dart';

class WalletsListCard extends StatelessWidget {
  const WalletsListCard({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.find<DashboardController>();
    bool isLight = Get.theme.brightness == Brightness.light;
    Color primary = Get.theme.primaryColor;
    Color onSurface = Get.theme.colorScheme.onSurface;
    Map<String, Map<String, dynamic>> typeMap = {
      "E-Wallet": {
        'bgCol': Get.theme.extension<FinanceColors>()?.ewallet,
        'fgCol': Get.theme.extension<FinanceColors>()?.onEwallet,
        'icon': Symbols.wallet,
      },
      "Bank": {
        'bgCol': Get.theme.extension<FinanceColors>()?.bank,
        'fgCol': Get.theme.extension<FinanceColors>()?.onBank,
        'icon': Symbols.account_balance,
      },
      "Cash": {
        'bgCol': Get.theme.extension<FinanceColors>()?.cash,
        'fgCol': Get.theme.extension<FinanceColors>()?.onCash,
        'icon': Symbols.money_bag,
      },
      "Stock": {
        'bgCol': Get.theme.extension<FinanceColors>()?.stock,
        'fgCol': Get.theme.extension<FinanceColors>()?.onStock,
        'icon': Symbols.finance,
      },
      "Others": {
        'bgCol': Get.theme.extension<FinanceColors>()?.others,
        'fgCol': Get.theme.extension<FinanceColors>()?.onOthers,
        'icon': Symbols.local_atm,
      },
    };

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            children: [
              CustomText.h3(
                "Wallets",
                color: isLight ? onSurface : primary,
                context: context,
              ),
              if (controller.wallets.isNotEmpty)
                ...controller.wallets.asMap().entries.map(
                  (wallet) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // spacing: 16,
                    children: [
                      GestureDetector(
                        onTap: () => InputLayout.showBottomSheet(
                          content: InputLayout.wallet(
                            wallet: wallet.value,
                            context: context,
                          ),
                        ),
                        child: Row(
                          spacing: 16,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: typeMap[wallet.value.type]?['bgCol'],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  typeMap[wallet.value.type]?['icon'],
                                  color: typeMap[wallet.value.type]?['fgCol'],
                                  size: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                spacing: 8,
                                children: [
                                  CustomText.normal(
                                    wallet.value.name ?? '-',
                                    isBold: true,
                                    context: context,
                                  ),
                                  CustomText.small(
                                    CustomConverter.doubleToCurrency(
                                      wallet.value.balance,
                                    ),
                                    context: context,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (wallet.key != controller.wallets.length - 1)
                        Divider(color: Get.theme.chipTheme.backgroundColor),
                    ],
                  ),
                ),
              if (controller.wallets.isEmpty)
                Center(child: CustomText.normal("No wallet", context: context)),
            ],
          ),
        ),
      ),
    );
  }
}
