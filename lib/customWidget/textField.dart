// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lam/constant.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Icon? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  const CustomTextField({
    Key? key,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.textInputType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 56.h,
      child: TextFormField(
        validator: validator,
        keyboardType: textInputType,
        controller: controller,
        style: TextStyle(
          color: Colors.white.withOpacity(.70),
          fontSize: 16.5,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          // isCollapsed: true,
          contentPadding: const EdgeInsets.all(13),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
              style: BorderStyle.solid,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: suffixIcon,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(.40),
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: const BorderSide(
              color: textBorderColor,
              width: 1.5,
              style: BorderStyle.solid,
            ),
          ),
          fillColor: const Color(0xffffffff).withOpacity(.03),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: const BorderSide(
              color: primaryColor1,
              style: BorderStyle.solid,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
