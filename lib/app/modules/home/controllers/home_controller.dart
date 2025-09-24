import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/theme_service.dart';
import '../../../data/models/page_model.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../history/views/history_view.dart';
import '../views/widgets/confirm_logout.dart';

class HomeController extends GetxController {
  List<PageModel> pages = [
    PageModel(name: 'Dashboard', page: DashboardView(), icon: Symbols.home),
    PageModel(name: 'History', page: HistoryView(), icon: Symbols.history),
  ];
  RxInt currentIndex = 0.obs;
  RxString currentThemeMode = 'Dark'.obs;

  String getCurrentTheme() => ThemeService().name;

  @override
  void onInit() {
    super.onInit();
    currentThemeMode.value = getCurrentTheme();
  }

  void updateCurrentTheme(String mode) {
    currentThemeMode.value = mode;
    ThemeService().switchTheme(mode);
  }

  dynamic getCurrentPage() => pages[currentIndex.value];

  void changePage(int index) {
    currentIndex.value = index;
  }

  void confirmLogout() async {
    try {
      await Get.dialog(ConfirmLogout(logout: logout));
    } catch (e) {
      Get.snackbar(
        'Logout failed',
        'Please try again later.',
        margin: EdgeInsets.all(16),
      );
    }
  }

  void logout() async {
    await AuthService.logout();
    Get.offNamed('/login');
  }
}
