import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/home_controller.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/internet_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<InternetController>(() => InternetController());
  }
}