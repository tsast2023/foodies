import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/comment.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var email = '';
  var password = '';
  var name = '';
  var isLoading = false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validEmail(String value) {
    if (!GetUtils.isEmail(value.trim())) {
      return "Please Provide Valid Email";
    }
    return null;
  }

  String? validPassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  Future<void> login() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    isLoading.value = true;

    formKey.currentState!.save();
    email = emailController.text;
    password = passwordController.text;
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        //if (value != null)
        User? user = FirebaseAuth.instance.currentUser;

        if (!user!.emailVerified) {
          snackMessage('please verify email first');
          return;
        }
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', user.email.toString());
        prefs.setString('name', user.displayName.toString());
        prefs.setString('photo', user.photoURL.toString());
        prefs.setString('uid', user.uid.toString());

        prefs.setString('password', passwordController.text.trim().toString());
        emailController.text = "";
        passwordController.text = "";
        // Get.offAllNamed('/homePageScreen');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        snackMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        snackMessage("Wrong password provided for that user.");
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }
}

class LogoutController {
  Future<void> signOut(context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    //  await GetStorage.init();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', "");
    prefs.setString('name', "");
    prefs.setString('photo', "");
    prefs.setString('uid', "");
    prefs.setString('password', "");

    /*   Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    ); */
  }
}
