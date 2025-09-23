import 'package:finance_tracker/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

import '../../history/controllers/history_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<HistoryController>(() => HistoryController(), fenix: true);
  }
}
