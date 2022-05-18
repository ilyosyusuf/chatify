import 'package:flutter/material.dart';

class BoxAllDecoration {
  static decor(Color color) => BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
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
