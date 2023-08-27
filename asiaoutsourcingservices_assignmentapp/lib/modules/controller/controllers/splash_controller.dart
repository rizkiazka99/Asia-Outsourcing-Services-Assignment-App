import 'dart:async';
import 'package:asiaoutsourcingservices_assignmentapp/router/screens.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  nextDestination() {
    return Timer(
      const Duration(seconds: 2),
      () => Get.offNamed(Routes.DASHBOARD)
    );
  }

  @override
  void onInit() {
    super.onInit();
    nextDestination();
  }

  @override
  void onClose() {
    super.onClose();
  }
}