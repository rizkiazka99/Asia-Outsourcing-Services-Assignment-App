import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/core/font_sizes.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/dashboard_controller.dart';
import 'package:asiaoutsourcingservices_assignmentapp/router/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icony/icony_ikonate.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PreferredSizeWidget appBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor,
      title: Text(
        'MARKETPEDIA',
        style: h4(),
      ),
      actions: [
        IconButton(
          onPressed: () {}, 
          icon: const Icon(
            Icons.notifications_outlined
          )
        )
      ],
    );
  }

  Widget body(DashboardController controller) {
    return Obx(() => PageStorage(
      bucket: controller.bucket, 
      child: controller.pages[controller.selectedIndex]
    ));
  }

  Widget bottomAppBarItem(int selectedIndex, DashboardController controller, String iconAsset, String name) {
    return Obx(() => InkWell(
      borderRadius: BorderRadius.circular(80),
      onTap: () {
        controller.selectedIndex = selectedIndex;
      },
      child: Column(
        children: [
          Ikonate(
            iconAsset,
            width: 30,
            height: 30,
            color: controller.selectedIndex != selectedIndex
                ? Colors.white : primaryColor
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: h5(
              color: controller.selectedIndex != selectedIndex
                  ? Colors.white : primaryColor,
              fontWeight: FontWeight.normal
            ),
          )
        ],
      )
    ));
  }

  Widget bottomAppBar(DashboardController controller) {
    return Theme(
      data: ThemeData(
        useMaterial3: false,
      ),
      child: BottomAppBar(
        height: 80,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        color: Colors.black,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.black,
        elevation: 8,
        notchMargin: 5,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bottomAppBarItem(0, controller, Ikonate.home_alt, 'Home'),
            bottomAppBarItem(1, controller, Ikonate.search, 'Search'),
            bottomAppBarItem(2, controller, Ikonate.list_alt, 'History'),
            bottomAppBarItem(3, controller, Ikonate.user, 'Profile')
          ],
        ),
      ),
    );
  }

  Widget floatingActionButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        Get.toNamed(Routes.CART);  
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
          size: 40,
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.find<DashboardController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: body(controller),
      bottomNavigationBar: bottomAppBar(controller),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}