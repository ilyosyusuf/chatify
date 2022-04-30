import 'package:flutter/material.dart';

class MyBoxDecoration {
  static get decor => BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 7,
            offset: Offset(2, 5),
          ),
        ],
      );
}
