import 'package:adpv_frontend/Views/AdminPage/utils.dart';
import 'package:flutter/material.dart';

void showAlertDialog(
  BuildContext context,
  String warningTitle,
  String warningContent,
  Function() onAcceptFunction,
) {
  void _onProceedPressed() {
    onAcceptFunction();
    Navigator.of(context).pop();
  }

  final Widget continueButton = ElevatedButton(
    onPressed: _onProceedPressed,
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
