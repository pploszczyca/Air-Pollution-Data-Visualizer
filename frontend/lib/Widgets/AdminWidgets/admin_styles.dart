import 'package:flutter/material.dart';

const adminGreenColor = Color.fromRGBO(36, 109, 114, 0.9);

BorderRadius basicBorderRadius = BorderRadius.circular(8);

MaterialStateProperty<EdgeInsetsGeometry?> buttonPadding =
    MaterialStateProperty.all(const EdgeInsets.all(20));

ButtonStyle proceedButtonStyle = ButtonStyle(
  side: MaterialStateProperty.all(
    const BorderSide(width: 1, color: Colors.grey),
  ),
  padding: buttonPadding,
  backgroundColor: MaterialStateProperty.all(adminGreenColor),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(borderRadius: basicBorderRadius),
  ),
  alignment: Alignment.centerLeft,
);

TextStyle defaultAdminTextStyle = const TextStyle(
  fontFamily: 'SofiaSans',
  fontSize: 23,
  color: Colors.black,
);

TextStyle proceedButtonTextStyle =
    const TextStyle(fontFamily: 'SofiaSans', fontSize: 16, color: Colors.white);
