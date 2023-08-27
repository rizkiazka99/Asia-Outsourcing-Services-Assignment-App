import 'package:asiaoutsourcingservices_assignmentapp/modules/view/screens/home_screen.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/screens/other_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final PageStorageBucket bucket = PageStorageBucket();
  
  RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int selectedIndex) =>
      this._selectedIndex.value = selectedIndex;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    print('dashboardController disposed');
    super.onClose();
  }

  void onItemTapped(int index) {
    selectedIndex = index;
  }

  final List<Widget> pages = [
    const HomeScreen(
      key: PageStorageKey('Page1'),
    ),
    const SearchScreen(
      key: PageStorageKey('Page2')
    ),
    const HistoryScreen(
      key: PageStorageKey('Page3'),
    ),
    const ProfileScreen(
      key: PageStorageKey('Page4'),
    )
  ];
}