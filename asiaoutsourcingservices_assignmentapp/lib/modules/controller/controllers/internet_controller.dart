import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetController extends GetxController {
  late StreamSubscription subscription;
  bool isDeviceConnectedToInternet = false;

  RxBool _connectedToInternet = true.obs;
  bool get connectedToInternet => _connectedToInternet.value;
  set connectedToInternet(bool connectedToInternet) =>
      this._connectedToInternet.value = connectedToInternet;

  @override
  void onInit() {
    super.onInit();
    getConnectivity();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }

  getConnectivity() => 
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnectedToInternet = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnectedToInternet) {
          connectedToInternet = false;
          print('Connected to Internet = $connectedToInternet');
        } else {
          connectedToInternet = true;
          print('Connected to Internet = $connectedToInternet');
        }
      }
  );
}