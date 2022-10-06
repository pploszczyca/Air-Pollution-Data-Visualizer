import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Center loadingInCenter() => Center(
      child: LoadingAnimationWidget.halfTriangleDot(
        size: 90,
        color: Colors.pink,
      ),
    );

AppBar buildAppBar(String title) => AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.pink,
        ),
      ),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.pink),
    );

PreferredSize buildFancyAppBar(String title) => PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(),
        centerTitle: false,
        title: Text(title),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.pink,
          fontFamily: 'Ubuntu Condensed',
          fontSize: 40,
          fontWeight: FontWeight.w500,
        ),
        titleSpacing: 20,
      ),
    );

BoxDecoration buildBackgroundBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromRGBO(21, 184, 194, 1),
          Color.fromRGBO(14, 14, 82, 0.9)
        ],
      ),
    );

const emptyField = 'Select Endpoint';
const compareEndpointsViewAppBar = 'Compare charts';
const endpointViewAppBar = 'Endpoint Details';
const spacer = '    ';
