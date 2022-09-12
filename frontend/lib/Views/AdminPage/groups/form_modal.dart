import 'package:adpv_frontend/Views/AdminPage/utils.dart';
import 'package:adpv_frontend/Views/snackbar.dart';
import 'package:flutter/material.dart';

MaterialStateProperty<EdgeInsetsGeometry?> buttonPadding =
    MaterialStateProperty.all(const EdgeInsets.all(20));

void showCreateGroupModal(
  BuildContext context,
  Function(String name) onCreateFunction,
) {
  showDialog(
    context: context,
    builder: (_) {
      final nameController = TextEditingController();
      return AlertDialog(
        title: const Text('Create new group'),
        content: TextFormField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Name'),
        ),
        actions: [
          TextButton(
            style: proceedButtonStyle,
            onPressed: () => onProceedPressed(
              nameController.text,
              onCreateFunction,
              context,
            ),
            child: Text(
              'Create',
              style: proceedButtonTextStyle,
            ),
          ),
          cancelButton(context)
        ],
      );
    },
  );
}

void onProceedPressed(name, onCreateFunction, context) {
  if (name == "") {
    buildSnackbar("Can't create group with no name", context);
  }
  onCreateFunction(name);
  Navigator.pop(context);
}
