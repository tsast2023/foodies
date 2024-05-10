import 'package:demoproject/admin/admin_login.dart';
import 'package:demoproject/admin/home_admin.dart';
import 'package:demoproject/pages/onboard.dart';
import 'package:demoproject/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';

import 'pages/bottomnav.dart';
import 'widget/app_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = publishableKey;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      /*  theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark), */
      theme: ThemeData(
        brightness: Brightness.light,
        // backgroundColor: const Color(0xfff8f8f8),
        primaryColor: Colors.black,
        secondaryHeaderColor: const Color(0xff3b22a1),
        cardColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        //backgroundColor: const Color(0xff06090d),
        primaryColor: Colors.white,
        secondaryHeaderColor: Colors.white,
        cardColor: const Color(0xff070606),
      ),
      home: Onboard(),
    );
  }
}
