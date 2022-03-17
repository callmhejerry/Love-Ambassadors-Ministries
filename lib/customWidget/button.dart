import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lam/constant.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  final void Function()? onTap;
  const CustomButton({Key? key, required this.buttonText, this.onTap})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedContainer(
        height: 56.h,
        width: 248.w,
        alignment: Alignment.center,
        child: Text(
          widget.buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        decoration: BoxDecoration(
          gradient: primaryGradientColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 15),
              color: const Color(0xff1466CC).withOpacity(.16),
              blurRadius: 30,
            ),
          ],
        ),
        duration: const Duration(seconds: 5),
        curve: Curves.easeInOut,
      ),
    );
  }
}
