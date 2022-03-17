// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lam/Screens/loginPage.dart';
import 'package:lam/firebase/fire_base_auth.dart';
import 'package:lam/validator.dart';

import '../customWidget/button.dart';
import '../customWidget/textField.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController userNameController;
  late TextEditingController phoneNumberController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    userNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    userNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 91.h,
              ),
              const Text(
                "Sign up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 92.h,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: "Name",
                      controller: nameController,
                      validator: Validator.nameValidator,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      controller: userNameController,
                      hintText: "User name",
                      validator: Validator.nameValidator,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      controller: emailController,
                      validator: Validator.emailvalidator,
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      controller: phoneNumberController,
                      hintText: "Phone number",
                      textInputType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      textInputType: TextInputType.visiblePassword,
                      hintText: "Password",
                      validator: Validator.passwordValidator,
                      suffixIcon: const Icon(
                        Icons.visibility_rounded,
                        color: Color(0xff3a3a3a),
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  buttonText: "Sign Up",
                  onTap: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      AuthService.signUpWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                        username: userNameController.text,
                        name: nameController.text,
                        phonenumber: phoneNumberController.text,
                        context: context,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
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
                        text: "Already have an account? "),
                    TextSpan(
                      text: "Log in",
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
    );
  }
}
