import 'package:flutter/material.dart';

appBar(String title, String rightTitle, VoidCallback rightButtonClick) {
  return AppBar(
    centerTitle: true,
    titleSpacing: 0,
    elevation: 3.0,
    shadowColor: Colors.lightGreen,
    leading: const BackButton(),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 18,
      ),
    ),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}
