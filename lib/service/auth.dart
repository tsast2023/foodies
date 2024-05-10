import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoproject/service/database.dart';
import 'package:demoproject/service/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Controller/Auth/LoginController.dart';

/* class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final BuildContext context;

  AuthMethods(this.context);
  getCurrentUser() async {
    return await auth.currentUser;
  }

  Future SignOut() async {
    try {
      await auth.signOut();
      await SharedPreferenceHelper().saveUserName("");
      await SharedPreferenceHelper().saveUserEmail("");
      await SharedPreferenceHelper().saveUserWallet('0');
      await SharedPreferenceHelper().saveUserId("");
      await SharedPreferenceHelper().saveUserPassword("");

      Navigator.pushReplacementNamed(context, '/signup');
    } catch (e) {
      print("Error during sign out: $e");
    }
  }

  Future deleteuser() async {
    User? user = await FirebaseAuth.instance.currentUser;
    user?.delete();
  }
} */

class ApiAuthServices {
  AuthController _authController = AuthController();

  // ignore: body_might_complete_normally_nullable
  Future<UserCredential?> SignIN(emailAddress, password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
      saveDataToDb().then((value) async {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        //Get.offAllNamed('/login');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future Login(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  CollectionReference userDatBaseReference =
      FirebaseFirestore.instance.collection("user");

  Future<void> saveDataToDb() async {
    User? user = FirebaseAuth.instance.currentUser;
    await userDatBaseReference.doc(user!.uid).set({
      'uid': user.uid,
      'name': _authController.name,
      'email': _authController.email,
      'url': '',
    });
    return;
  }
}
