import 'package:FoodDeliveryApp/screens/signup.dart';
import 'package:FoodDeliveryApp/widgets/haveAccount.dart';
import 'package:FoodDeliveryApp/widgets/myButton.dart';
import 'package:FoodDeliveryApp/widgets/myPasswordTextFormField.dart';
import 'package:FoodDeliveryApp/widgets/myTextFormField.dart';
import 'package:FoodDeliveryApp/widgets/toptitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homeScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLoading = false;
  UserCredential authResult;
  void submit() async {
    setState(() {
      isLoading = true;
    });
    try {
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on PlatformException catch (e) {
      var message = "Please Check Internet Connectioin";
      if (e.message != null) {
        message = e.message.toString();
      }
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text(message.toString()),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void validation() {
    if (email.text.isEmpty && password.text.isEmpty) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text("Both Filled is empty!"),
        ),
      );
    } else if (email.text.isEmpty) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text("Email is empty!"),
        ),
      );
    } else if (password.text.isEmpty) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text("Password is empty!"),
        ),
      );
    } else if (password.text.length < 4) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text("Password is too short!"),
        ),
      );
    } else if (!email.text.contains("@")) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text("Email is Invalid!"),
        ),
      );
    } else {
      submit();
    }
  }

  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff8f8f8),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TopTitle("Login", "Welcome Back!"),
              Center(
                child: Container(
                  height: 170,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextFormField("Email", email),
                      SizedBox(height: 10),
                      MyPasswordTextFormField("Password", password),
                    ],
                  ),
                ),
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : MyButton("Login", () {
                      validation();
                    }),
              SizedBox(height: 10),
              HaveAccount(
                "Don't have an Account?",
                "Signup",
                () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => SignUp(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
