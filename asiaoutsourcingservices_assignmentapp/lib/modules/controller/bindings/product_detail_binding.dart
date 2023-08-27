import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/internet_controller.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/product_detail_controller.dart';
import 'package:get/get.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
    Get.lazyPut<InternetController>(() => InternetController());
  }
}