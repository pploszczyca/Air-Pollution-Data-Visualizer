import 'package:flutter/material.dart';

Card groupCard(Widget titleCard, List<Widget> children) => Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: titleCard,
        collapsedBackgroundColor: Colors.white,
        tilePadding: const EdgeInsets.all(20),
        childrenPadding: const EdgeInsets.all(0),
        children: [...children.map((e) => e).toList()],
      ),
    );

Container buildInfoContainer(String title, String data, double width) =>
    Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'SofiaSans',
                fontWeight: FontWeight.w700,
                color: Colors.black45,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            width: width * 0.5,
            child: Text(
              data,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'SofiaSans',
                color: Colors.black45,
              ),
            ),
          )
        ],
      ),
    );
