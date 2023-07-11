import 'package:cc/screens/authentication/sign_in.dart';
import 'package:cc/services/store_userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home/home.dart';

class AuthService {
  static String message = '';
  static String userId = '';

  Future<String?> signUp(username, phone, email, password) async {
    if (username == '') {
      message = 'please enter your user_name';
    } else {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          message = value.toString();
          userId = value.user!.uid;

          FireStore()
              .storeUserData(value.user!.uid, username, phone, email, password);
        });
        message = 'Success';
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        } else {
          message = e.message.toString();
        }
      } catch (e) {
        message = e.toString();
      }
    }
  }

  // Future<void> signInWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  static var loginEmail;
  static var loginPassword;
  sinIn(String email, String password, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        print(value.user?.isAnonymous.toString());

        message = 'Success';
        userId = value.user!.uid;
        loginEmail = value.user!.email;

        print(value.user!.uid + 'this a user uid ');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      });
    } catch (e) {
      message = e.toString();
      print(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> signOut(context) async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        message = 'Logout';
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) {
          return SignInScreen();
        }), (route) => false);
        return value;
      });
    } catch (e) {
      message = e.toString();
      print(e.toString());
    }
  }
}
