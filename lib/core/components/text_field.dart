import 'package:chatify/core/constants/colors.dart';
import 'package:flutter/material.dart';

class MyTextField{
  static textField(
      {required String text,
      IconButton? iconButton,
      // Icon? suffixIcon,
      required TextEditingController controller,
      Icon? prefixIcon, bool read = false, var onChanged, VoidCallback? onTap, bool? obscure = false, String? validator}) {
    return TextFormField(
      controller: controller,
      readOnly: read,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscure!,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(color: Colors.grey),
        suffixIcon: iconButton,
        prefixIcon: prefixIcon,
        fillColor: ColorConst.kTextField,
        filled: true,
                  focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: ColorConst.kPrimaryColor),
          ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      validator: (v)=> v!.isEmpty ? validator : "",
      
      // (v)=> v!.length < 5 ? "5 tadan kam bo'lmasin!" : null
    );
  }
}