import 'package:FoodDeliveryApp/screens/homeScreen.dart';
import 'package:FoodDeliveryApp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapShot) {
        if (snapShot.hasData) {
          return HomeScreen();
        } else {
          return Login();
        }
      },
    );
  }
}
