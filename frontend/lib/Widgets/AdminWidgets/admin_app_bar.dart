import 'package:flutter/material.dart';

import 'admin_styles.dart';

PreferredSize adminAppBar(String upperText, String bottomText) => PreferredSize(
      preferredSize: const Size.fromHeight(120),
      child: AppBar(
        iconTheme: const IconThemeData(
          color: adminGreenColor,
        ),
        centerTitle: true,
        toolbarHeight: 120,
        title: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(upperText),
        ),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Ubuntu Condensed',
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
        titleSpacing: 20,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, top: 5),
            alignment: Alignment.center,
            child: Text(
              bottomText,
              style: const TextStyle(
                fontSize: 25,
                color: Color.fromRGBO(128, 128, 128, 1),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
