import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../dashboard/views/widgets/input_layout.dart';
import '../controllers/home_controller.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_navigation_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => CustomAppBar(
            title: controller.getCurrentPage().name,
            currentThemeName: controller.currentThemeMode.value,
            onChanged: controller.updateCurrentTheme,
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => CustomNavigationBar(
          pages: controller.pages,
          changePage: controller.changePage,
          index: controller.currentIndex.value,
        ),
      ),
      floatingActionButton: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            if (controller.isMenuExpanded.value) ...[
              FloatingActionButton(
                onPressed: () =>
                    Get.dialog(InputLayout.wallet(context: context)),
                tooltip: "Add new wallet",
                shape: CircleBorder(),
                mini: true,
                child: Icon(Symbols.account_balance_wallet),
              ),
              FloatingActionButton(
                onPressed: () {},
                tooltip: "Move money",
                shape: CircleBorder(),
                mini: true,
                child: Icon(Symbols.swap_horiz),
              ),
              FloatingActionButton(
                onPressed: () {},
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
              child: Icon(Symbols.add),
            ),
          ],
        ),
      ),
      body: Obx(() => controller.getCurrentPage().page),
    );
  }
}
