import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/core/font_sizes.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final void Function()? onTap;
  final double? width;
  final double? height;
  final Color buttonColor;
  final String buttonText;
  final Color buttonTextColor;

  const DefaultButton({
    super.key,
    required this.onTap,
    this.width, 
    this.height, 
    this.buttonColor = primaryColor, 
    required this.buttonText,
    this.buttonTextColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), 
          color: buttonColor
        ),
        child: Center(
          child: Text(
            buttonText,
            style: buttonLg(
              color: buttonTextColor,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}