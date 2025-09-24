import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
            confirmLogout: controller.confirmLogout,
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

      body: Obx(() => controller.getCurrentPage().page),
    );
  }
}
