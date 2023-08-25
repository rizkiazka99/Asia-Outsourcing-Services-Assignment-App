import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/router/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asia Outsourcing Services - Assignment App',
      theme: ThemeData(
        colorSchemeSeed: primaryColor,
        useMaterial3: true,
        fontFamily: 'Poppins'
      ),
      getPages: AppScreens.SCREENS,
      initialRoute: AppScreens.INITIAL,
    );
  }
}