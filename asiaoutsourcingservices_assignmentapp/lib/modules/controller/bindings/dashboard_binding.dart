import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/dashboard_controller.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/internet_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<InternetController>(() => InternetController());
  }
}