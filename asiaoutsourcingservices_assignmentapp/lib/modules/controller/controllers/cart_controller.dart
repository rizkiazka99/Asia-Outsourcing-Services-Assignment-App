import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/sqlite_provider.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    SQLHelper.getItems();
  }

  @override
  void onClose() {
    super.onClose();
  }
}