import 'package:flutter/material.dart';

import 'admin_styles.dart';

Container editButtonContainer(VoidCallback onPressed) => Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            const BorderSide(width: 1.5, color: Colors.teal),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(20),
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) =>
                states.contains(MaterialState.hovered)
                    ? Colors.white
                    : Colors.teal,
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) =>
                states.contains(MaterialState.hovered)
                    ? Colors.teal
                    : Colors.white,
          ),
          alignment: Alignment.centerLeft,
        ),
        onPressed: onPressed,
        child: const Icon(Icons.edit, size: 30),
      ),
    );

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

TextButton discardChangesButton(BuildContext context) => TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Colors.red),
          ),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        "Discard",
        style: defaultAdminTextStyle.copyWith(
          color: Colors.red,
        ),
      ),
    );

TextButton saveButton(VoidCallback onPressed) => TextButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => adminGreenColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        "Save changes",
        style: defaultAdminTextStyle.copyWith(
          color: Colors.white,
        ),
      ),
    );

Container deleteButtonContainer(VoidCallback onPressed) => Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            const BorderSide(width: 1.5, color: Colors.red),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(20),
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
        onPressed: onPressed,
        child: const Icon(Icons.delete_outline_outlined, size: 30),
      ),
    );

Row buildDeleteEditButtonRow(
  VoidCallback onDeletePressed,
  VoidCallback onEditPressed,
) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        deleteButtonContainer(onDeletePressed),
        editButtonContainer(onEditPressed)
      ],
    );
