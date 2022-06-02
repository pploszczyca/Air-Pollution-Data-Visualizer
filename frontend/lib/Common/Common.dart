import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Center LoadingInCenter() {
  return Center(
    child: LoadingAnimationWidget.halfTriangleDot(
      size: 90,
      color: Colors.pink,
    ),
  );
}