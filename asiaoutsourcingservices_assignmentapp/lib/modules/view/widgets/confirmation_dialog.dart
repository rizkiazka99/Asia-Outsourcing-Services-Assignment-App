import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/core/font_sizes.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/default_button.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function() onConfirmation;
  final void Function() onCancellation;
  
  const ConfirmationDialog({
    super.key, 
    required this.title, 
    required this.content, 
    required this.onConfirmation,
    required this.onCancellation
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        useMaterial3: false,
        canvasColor: Colors.white
      ),
      child: AlertDialog(
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: h5(),
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          style: bodyMd(color: contextGrey),
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: DefaultButton(
                  height: 50,
                  useIcon: false,
                  onTap: onConfirmation, 
                  buttonColor: contextOrange, 
                  buttonText: 'Yes'
                )
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DefaultButton(
                  height: 50,
                  useIcon: false,
                  onTap: onCancellation, 
                  buttonColor: contextRed, 
                  buttonText: 'No'
                )
              )
            ],
          )
        ],
      ),
    );
  }
}