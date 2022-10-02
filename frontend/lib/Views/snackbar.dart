import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackbar(
  String message,
  BuildContext context, {
  int? duration,
  double? height,
  Color? color,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          alignment: Alignment.center,
          height: height ?? 40,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Text(
            message,
            style: TextStyle(
              color: color ?? Colors.red,
              fontFamily: 'Ubuntu Condensed',
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        elevation: 1,
        duration: Duration(seconds: duration ?? 15),
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
      ),
    );
