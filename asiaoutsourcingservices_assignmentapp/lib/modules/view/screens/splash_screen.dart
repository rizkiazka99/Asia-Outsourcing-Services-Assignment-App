import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/core/font_sizes.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController controller = Get.find<SplashController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  'assets/images/splash_logo.jpg'
                ),
                Text(
                  'Flutter Programmer Skill Test',
                  style: h3(),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'by Rizki Azka',
                  style: h4(),
                ),
                const Spacer(),
                const SpinKitFoldingCube(
                  color: primaryColor,
                  size: 25,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}