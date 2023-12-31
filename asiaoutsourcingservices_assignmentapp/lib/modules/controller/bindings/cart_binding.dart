import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/cart_controller.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/internet_controller.dart';
import 'package:get/get.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<InternetController>(() => InternetController());
  }
}