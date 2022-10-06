import 'package:flutter/material.dart';

import '../enpoint_list_view.dart';

const adminGreenColor = Color.fromRGBO(36, 109, 114, 0.9);

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

PreferredSize adminAppBar(String upperText, String bottomText) => PreferredSize(
      preferredSize: const Size.fromHeight(120),
      child: AppBar(
        iconTheme: const IconThemeData(
          color: adminGreenColor,
        ),
        centerTitle: true,
        toolbarHeight: 120,
        title: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(upperText),
        ),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Ubuntu Condensed',
          fontSize: 40,
          fontWeight: FontWeight.w500,
        ),
        titleSpacing: 20,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, top: 5),
            child: Text(
              bottomText,
              style: const TextStyle(fontSize: 25),
            ),
          ),
        ),
      ),
    );


PreferredSize buildAdminAppBar(String bottomText) => PreferredSize(
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

Container buildDeleteContainer(Function onDeletePressed, arguments) => Container(
  alignment: Alignment.centerRight,
  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
  child: OutlinedButton(
    style: ButtonStyle(
      side: MaterialStateProperty.all(
        const BorderSide(width: 1.5, color: Colors.red),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.all(15),
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) =>
        states.contains(MaterialState.hovered)
            ? Colors.white
            : Colors.red,
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) =>
        states.contains(MaterialState.hovered)
            ? Colors.red
            : Colors.white,
      ),
      alignment: Alignment.centerLeft,
    ),
    child: const Icon(Icons.delete_outline_outlined, size: 30),
    onPressed: () => onDeletePressed(arguments),
  ),
);
