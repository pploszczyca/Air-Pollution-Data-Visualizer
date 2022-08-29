import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cancelButton(BuildContext context) => OutlinedButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: const Text('Cancel'));
