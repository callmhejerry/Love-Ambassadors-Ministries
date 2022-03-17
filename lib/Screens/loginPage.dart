// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lam/Screens/signUp.dart';
import 'package:lam/customWidget/button.dart';
import 'package:lam/firebase/fire_base_auth.dart';
import 'package:lam/validator.dart';

import '../customWidget/textField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 91.h,
                ),
                const Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 202.h,
                ),
                CustomTextField(
                  hintText: "Email",
                  controller: emailController,
                  validator: Validator.emailvalidator,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  // validator: Validator.passwordValidator,
                  suffixIcon: const Icon(
                    Icons.visibility_rounded,
                    color: Color(0xff3a3a3a),
                  ),
                ),
                SizedBox(
                  height: 150.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    buttonText: "Log in",
                    onTap: () {
                      _formkey.currentState!.save();
                      if (_formkey.currentState!.validate()) {
                        AuthService.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 70.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          style: TextStyle(
                            color: Color(0xffB7B0B0),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Nunito",
                          ),
                          text: "Dont have an account? "),
                      TextSpan(
                        text: "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Nunito",
                        ),
                      ),
                    ])),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
