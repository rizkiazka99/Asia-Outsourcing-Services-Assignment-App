import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget backButton() {
  return IconButton(
    onPressed: () {
      Get.back();
    },
    icon: Container(
      width: 50,
      padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 2,
            color: contextGrey.withOpacity(0.2),
            offset: const Offset(0, 3)
          )
        ]
      ),
      child: const Icon(
        Icons.arrow_back_ios
      ),
    )
  );
}