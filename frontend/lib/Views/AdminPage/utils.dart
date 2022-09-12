import 'package:flutter/material.dart';

import '../enpoint_list_view.dart';
import 'groups/groups_view.dart';

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
          fontFamily: 'SofiaSans',
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );


PreferredSize buildAppBar(String bottomText) => PreferredSize(
  preferredSize: const Size.fromHeight(120),
  child: AppBar(
    iconTheme: const IconThemeData(
      color: adminGreenColor,
    ),
    centerTitle: true,
    toolbarHeight: 120,
    title: Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: const Text("Administrator panel"),
    ),
    backgroundColor: Colors.white,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontFamily: 'Ubuntu Condensed',
      fontSize: 40,
      fontWeight: FontWeight.w500,
    ),
    titleSpacing: 20,
    bottom: bottomText != "" ?  PreferredSize(
      preferredSize: const Size.fromHeight(20),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10, top: 5),
        child: Text(
          bottomText,
          style: const TextStyle(fontSize: 25),
        ),
      ),
    ) : null,
  ),
);