import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: GlassmorphicContainer(
        width: 319.w,
        height: 284.h,
        borderRadius: 10,
        border: 2,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.1),
            const Color(0xFFFFFFFF).withOpacity(0.05),
          ],
          stops: const [
            0.1,
            1,
          ],
        ),
        blur: 20,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                "Images/email1.png",
                height: 104.h,
                width: 88.w,
              ),
              const Text(
                "Email confirmation",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RichText(
                softWrap: true,
                text: const TextSpan(children: [
                  TextSpan(
                    text: "We have sent an email to ",
                  ),
                  TextSpan(
                      text: "chinedujeremiah2002@gmail.com",
                      style: TextStyle(
                        color: Colors.orange,
                      )),
                  TextSpan(
                    text:
                        "to confirm the validity of your email address. After receiving the email follow the link provided to complete your registration.",
                  ),
                ]),
              )
            ],
          ),
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.5),
            const Color((0xFFFFFFFF)).withOpacity(0.5),
          ],
        ),
      ),
    );
  }
}
