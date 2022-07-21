import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Center LoadingInCenter() => Center(
      child: LoadingAnimationWidget.halfTriangleDot(
        size: 90,
        color: Colors.pink,
      ),
    );

AppBar buildAppBar(String title) => AppBar(
      title: Text(title,
          style: const TextStyle(
            color: Colors.pink,
          )),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.pink),
    );
const ignoreField = 'timestamp';
const emptyField = 'Select Endpoint';
const compareEndpointsViewAppBar = 'Compare charts';
const endpointViewAppBar = 'Endpoint Details';
