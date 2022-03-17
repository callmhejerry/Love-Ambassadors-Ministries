import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lam/customWidget/dialog.dart';

import '../Screens/email_verification.dart';

class AuthService {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static bool isEmailVerified() {
    return firebaseAuth.currentUser!.emailVerified;
  }

  static signUpWithEmailAndPassword({
    required String email,
    required String password,
    required username,
    required name,
    required phonenumber,
    required BuildContext context,
  }) async {
    try {
      showDialog(
        context: context,
        builder: (context) => const CustomDialog(),
      );
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email.toLowerCase().trim(), password: password);

      User? user = firebaseAuth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();

        CollectionReference usersCollection = fireStore.collection("Users");
        Map data = {
          "email": email,
          "password": password,
          "name": name,
          "user name": username,
          "phone number": phonenumber,
        };
        usersCollection.add(data);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EmailVerificationScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      if (e.code == "email-already-in-use") {
        Fluttertoast.showToast(
          msg: "email-already-in-use",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  static signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      firebaseAuth.signInWithEmailAndPassword(
          email: email.toLowerCase().trim(), password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    }
  }

  static Stream<User?> authState() {
    return firebaseAuth.authStateChanges();
  }

  static signOut() {
    firebaseAuth.signOut();
  }
}
