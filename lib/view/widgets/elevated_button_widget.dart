import 'package:chatify/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  ElevatedButtonWidget({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 15.0,
          primary: ColorConst.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          fixedSize: Size(MediaQuery.of(context).size.width, 50)),
      child: Text(text),
    );
  }
}
