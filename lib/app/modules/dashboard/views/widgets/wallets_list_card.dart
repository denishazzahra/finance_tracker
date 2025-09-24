import 'package:finance_tracker/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/theme/finance_color.dart';
import '../../../../../core/utils/custom_converter.dart';
import '../../../../../core/widgets/custom_text.dart';

class WalletsListCard extends StatelessWidget {
  const WalletsListCard({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.find<DashboardController>();
    bool isLight = Theme.of(context).brightness == Brightness.light;
    Color primary = Theme.of(context).primaryColor;
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    Map<String, Map<String, dynamic>> typeMap = {
      "E-Wallet": {
        'bgCol': Theme.of(context).extension<FinanceColors>()?.ewallet,
        'fgCol': Theme.of(context).extension<FinanceColors>()?.onEwallet,
        'icon': Symbols.wallet,
      },
      "Bank": {
        'bgCol': Theme.of(context).extension<FinanceColors>()?.bank,
        'fgCol': Theme.of(context).extension<FinanceColors>()?.onBank,
        'icon': Symbols.account_balance,
      },
      "Cash": {
        'bgCol': Theme.of(context).extension<FinanceColors>()?.cash,
        'fgCol': Theme.of(context).extension<FinanceColors>()?.onCash,
        'icon': Symbols.money_bag,
      },
      "Stock": {
        'bgCol': Theme.of(context).extension<FinanceColors>()?.stock,
        'fgCol': Theme.of(context).extension<FinanceColors>()?.onStock,
        'icon': Symbols.finance,
      },
      "Others": {
        'bgCol': Theme.of(context).extension<FinanceColors>()?.others,
        'fgCol': Theme.of(context).extension<FinanceColors>()?.onOthers,
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
                context: context,
                color: isLight ? onSurface : primary,
                // isBold: true,
              ),
              if (controller.wallets.isNotEmpty)
                ...controller.wallets.asMap().entries.map(
                  (wallet) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // spacing: 16,
                    children: [
                      Row(
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              CustomText.normal(
                                wallet.value.name ?? '-',
                                context: context,
                                isBold: true,
                              ),
                              CustomText.small(
                                CustomConverter.doubleToCurrency(
                                  wallet.value.balance,
                                ),
                                context: context,
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (wallet.key != controller.wallets.length - 1)
                        Divider(
                          color: Theme.of(context).chipTheme.backgroundColor,
                        ),
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
