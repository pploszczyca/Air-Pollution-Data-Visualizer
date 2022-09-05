import 'package:flutter/material.dart';

import '../enpoint_list_view.dart';
import 'groups_view.dart';

MaterialStateProperty<EdgeInsetsGeometry?> buttonPadding =
    MaterialStateProperty.all(const EdgeInsets.all(20));

ButtonStyle proceedButtonStyle = ButtonStyle(
  side: MaterialStateProperty.all(
    const BorderSide(width: 1, color: Colors.grey),
  ),
  padding: buttonPadding,
  backgroundColor: MaterialStateProperty.all(floatingButtonColor),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(borderRadius: basicBorderRadius),
  ),
  alignment: Alignment.centerLeft,
);

TextStyle proceedButtonTextStyle =
    const TextStyle(fontFamily: 'SofiaSans', fontSize: 16, color: Colors.white);

Widget cancelButton(BuildContext context) => OutlinedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          const BorderSide(width: 1, color: Colors.grey),
        ),
        padding: buttonPadding,
      ),
      child: const Text(
        'Cancel',
        style: TextStyle(
            fontFamily: 'SofiaSans', fontSize: 16, color: Colors.grey),
      ),
    );
