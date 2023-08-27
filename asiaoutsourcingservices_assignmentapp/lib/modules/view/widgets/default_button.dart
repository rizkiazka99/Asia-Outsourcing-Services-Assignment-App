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
  final bool useIcon;
  final IconData? icon;

  const DefaultButton({
    super.key,
    required this.onTap,
    this.width, 
    this.height, 
    this.buttonColor = primaryColor, 
    required this.buttonText,
    this.buttonTextColor = Colors.white,
    required this.useIcon,
    this.icon
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
        child: useIcon ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 15),
            Text(
              buttonText,
              style: buttonLg(
                color: buttonTextColor,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ) : Center(
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