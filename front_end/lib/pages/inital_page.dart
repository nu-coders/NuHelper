import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:front_end/pages/home_page.dart';
import 'package:front_end/pages/login_screen.dart';

class IntialPage extends StatelessWidget {
  const IntialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // if (FirebaseAuth.instance.currentUser!.emailVerified) {
              return  HomePage();
            // }
            // FirebaseAuth.instance.signOut();
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     duration: Duration(),
            //     content: Text("Please verify your email."),
            //   ),
            // );
            // print("dataaaaaaa:${snapshot.hasData}");
            // print("please verify your email");
          }
          return  LoginPage();
        },
      ),
    );
  }
}
