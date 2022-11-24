import 'package:flutter/cupertino.dart';

void scrollDown(ScrollController controller) {
  controller.animateTo(
    controller.position.maxScrollExtent,
    duration: const Duration(seconds: 2),
    curve: Curves.fastOutSlowIn,
  );
}
