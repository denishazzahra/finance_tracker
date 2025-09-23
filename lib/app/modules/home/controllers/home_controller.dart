import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/theme_service.dart';
import '../../../data/models/page_model.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../history/views/history_view.dart';

class HomeController extends GetxController {
  List<PageModel> pages = [
    PageModel(name: 'Dashboard', page: DashboardView(), icon: Symbols.home),
    PageModel(name: 'History', page: HistoryView(), icon: Symbols.history),
  ];
  RxInt currentIndex = 0.obs;
  RxString currentThemeMode = 'Dark'.obs;
  RxBool isMenuExpanded = false.obs;

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

  void toggleMenu() {
    isMenuExpanded.value = !isMenuExpanded.value;
  }
}
