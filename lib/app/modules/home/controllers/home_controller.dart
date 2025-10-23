import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/theme_service.dart';
import '../../../data/models/page_model.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../history/views/history_view.dart';
import '../../insight/views/insight_view.dart';

class HomeController extends GetxController {
  List<PageModel> pages = [
    PageModel(name: 'Dashboard', page: DashboardView(), icon: Symbols.home),
    PageModel(name: 'History', page: HistoryView(), icon: Symbols.history),
    PageModel(name: 'Insight', page: InsightView(), icon: Symbols.analytics),
  ];
  RxInt currentIndex = 0.obs;
  RxString currentThemeMode = 'Dark'.obs;
  SharedPreferences prefs = Get.find<SharedPreferences>();

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

  void logout() async {
    await AuthService.logout();
    await prefs.clear();
    Get.offAllNamed('/login');
  }
}
