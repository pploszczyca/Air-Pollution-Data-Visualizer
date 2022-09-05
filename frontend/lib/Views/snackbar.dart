import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackbar(
        String message, BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.red,
              fontFamily: 'Ubuntu Condensed',
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        elevation: 1,
        duration: const Duration(seconds: 15),
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
      ),
    );
