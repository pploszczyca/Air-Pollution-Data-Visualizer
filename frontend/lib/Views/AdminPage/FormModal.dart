import 'package:flutter/material.dart';

void showCreateGroupModal(BuildContext context, Function(String name) onCreateFunction) {
  showDialog(
    context: context,
    builder: (_) {
      var _nameController = TextEditingController();
      return AlertDialog(
        title: Text('Create new group'),
        content: Container(
          child:
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => onProceedPressed(_nameController.text, onCreateFunction, context),
            child: Text('Create'),
          ),
        ],
      );
    },
  );
}

onProceedPressed(name, onCreateFunction, context) {
  onCreateFunction(name);
    Navigator.pop(context);
}