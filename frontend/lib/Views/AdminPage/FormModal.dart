import 'package:adpv_frontend/Views/AdminPage/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showFormModal(BuildContext context, String title, onCreateFunction) {
  _onProceedPressed() {
    onCreateFunction();
    Navigator.of(context).pop();
  }

  final Widget continueButton = ElevatedButton(
    onPressed: _onProceedPressed,
    child: const Text("Create"),
  );

  final TextEditingController _inputController = TextEditingController();

  final AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Container(
      padding: const EdgeInsets.symmetric(vertical: 10; horizontal: 20),
        child: Column(
          children: [
            Theme(
              data: Theme.of(context).copyWith(colorScheme: loginPageTheme),
              child: TextField(
                controller: controller,
                obscureText: true,
                decoration: const InputDecoration(
                  focusedBorder: focusedInputBorder,
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 22,
                  ),
                  suffixIcon: Icon(Icons.lock),
                  border: inputBorder,
                ),
                autofocus: true,
              ),
            ),
          ],
        ),),
    actions: [continueButton, cancelButton(context)],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) => alert,
  );
}