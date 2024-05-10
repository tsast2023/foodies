import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:get_storage/get_storage.dart';

class LogoutController {
  Future<void> signOut(context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    //await GetStorage.init();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', "");
    prefs.setString('name', "");
    prefs.setString('photo', "");
    prefs.setString('uid', "");
    prefs.setString('password', "");

    /*  Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    ); */
  }
}
