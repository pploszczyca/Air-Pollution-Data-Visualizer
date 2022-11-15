import 'package:flutter/material.dart';

import 'admin_buttons.dart';
import 'admin_styles.dart';

void showAlertDialog(
  BuildContext context,
  String warningTitle,
  String warningContent,
  Function() onAcceptFunction,
) {
  void onProceedPressed() {
    onAcceptFunction();
    Navigator.of(context).pop(true);
  }

  final Widget continueButton = ElevatedButton(
    onPressed: onProceedPressed,
    style: proceedButtonStyle,
    child: Text("Proceed", style: proceedButtonTextStyle),
  );

  final AlertDialog alert = AlertDialog(
    title: Text(warningTitle),
    content: Text(warningContent),
    actions: [cancelButton(context), continueButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) => alert,
  );
}
