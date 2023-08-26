import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/core/font_sizes.dart';
import 'package:flutter/material.dart';

Widget productRating(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width / 6,
    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
    decoration: BoxDecoration(
        color: primaryColor, borderRadius: BorderRadius.circular(4)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.star_border_rounded,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(width: 2),
        Text(
          '4.5',
          style: bodyMd(color: Colors.white),
        )
      ],
    ),
  );
}
