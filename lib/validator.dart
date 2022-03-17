import 'package:email_validator/email_validator.dart';

class Validator {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return "Please input your name";
    }
    return null;
  }

  static String? emailvalidator(String? email) {
    if (email == null || email.isEmpty) {
      return "please input your email ";
    } else if (email.isEmpty == false) {
      if (EmailValidator.validate(email)) {
        return null;
      } else {
        return "Input a valid email";
      }
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return "please input your password ";
    }
    if (password.length < 8) {
      return "password must be atleast 8 characters";
    }
    return null;
  }
}
