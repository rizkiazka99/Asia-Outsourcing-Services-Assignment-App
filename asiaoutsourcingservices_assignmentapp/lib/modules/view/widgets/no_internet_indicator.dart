import 'package:asiaoutsourcingservices_assignmentapp/core/font_sizes.dart';
import 'package:flutter/material.dart';

Widget noInternetIndicator(BuildContext context) {
  return Container(
    height: 100,
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.withOpacity(0.2)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 6,
          child: Image.asset(
            'assets/images/no_internet.png', 
            width: 60, 
            height: 60
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Text(
            'Internet connection unavailable',
            style: h5(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}