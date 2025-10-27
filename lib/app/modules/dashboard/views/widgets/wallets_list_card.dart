import 'package:finance_tracker/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/consts/app_const.dart';
import '../../../../../core/utils/custom_converter.dart';
import '../../../../../core/widgets/custom_icon.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'input_layout.dart';

class WalletsListCard extends StatelessWidget {
  const WalletsListCard({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.find<DashboardController>();
    bool isLight = Theme.of(context).brightness == Brightness.light;
    Color primary = Theme.of(context).primaryColor;
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    Color? chipColor = Theme.of(context).chipTheme.backgroundColor;

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
              controller.isLoading.value
                  ? Skeletonizer(
                      enabled: controller.isLoading.value,
                      containersColor: chipColor,
                      child: Row(
                        spacing: 16,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: chipColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 8,
                              children: [
                                CustomText.normal(
                                  'aaaaaaaaaaaaaaaaaaaaa',
                                  isBold: true,
                                  context: context,
                                ),
                                CustomText.small('aaaaaaaaa', context: context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : controller.wallets.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => InputLayout.showBottomSheet(
                            content: InputLayout.wallet(
                              wallet: controller.wallets[index],
                              context: context,
                            ),
                          ),
                          child: Row(
                            spacing: 16,
                            children: [
                              CustomIcon.display(
                                bgCol: walletTypeMap(
                                  context,
                                )[controller.wallets[index].type]?['bgCol'],
                                iconCol: walletTypeMap(
                                  context,
                                )[controller.wallets[index].type]?['fgCol'],
                                icon: walletTypeMap(
                                  context,
                                )[controller.wallets[index].type]?['icon'],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  spacing: 8,
                                  children: [
                                    CustomText.normal(
                                      controller.wallets[index].name ?? '-',
                                      isBold: true,
                                      context: context,
                                    ),
                                    CustomText.small(
                                      CustomConverter.doubleToCurrency(
                                        controller.wallets[index].balance,
                                      ),
                                      context: context,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          Divider(color: chipColor),
                      itemCount: controller.wallets.length,
                    )
                  : Center(
                      child: CustomText.normal("No wallet", context: context),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
