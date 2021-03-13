import 'package:FoodDeliveryApp/screens/homeScreen.dart';
import 'package:FoodDeliveryApp/screens/login.dart';
import 'package:FoodDeliveryApp/widgets/haveAccount.dart';
import 'package:FoodDeliveryApp/widgets/myButton.dart';
import 'package:FoodDeliveryApp/widgets/myPasswordTextFormField.dart';
import 'package:FoodDeliveryApp/widgets/myTextFormField.dart';
import 'package:FoodDeliveryApp/widgets/toptitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  bool isMale = true;
  final TextEditingController email = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLoading = false;
  UserCredential authResult;
  void submit() async {
    setState(() {
      isLoading = true;
    });
    try {
      authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      await FirebaseFirestore.instance
          .collection("userData")
          .doc(authResult.user.uid)
          .set({
        "Username": fullName.text,
        "UserEmail": email.text,
        "UserId": authResult.user.uid,
        "UserNumber": phoneNumber.text,
        "UserAddress": address.text,
        "UserGender": isMale == true ? "Male" : "Female",
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        ),
      );
    } on PlatformException catch (e) {
      var message = "Please Check Internet Connectioin";
      if (e.message != null) {
        message = e.message.toString();
      }
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void validation() {
    if (email.text.isEmpty &&
        password.text.isEmpty &&
        fullName.text.isEmpty &&
        address.text.isEmpty &&
        phoneNumber.text.isEmpty) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text("All Filled are empty!"),
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
    } else if (fullName.text.isEmpty) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text("Full Name is empty!"),
        ),
      );
    } else if (address.text.isEmpty) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text("Address is empty!"),
        ),
      );
    } else if (phoneNumber.text.isEmpty) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text("Phone Number is empty!"),
        ),
      );
    } else if (phoneNumber.text.length < 11) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text("Phone number must be 11 charcters!"),
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xfff8f8f8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TopTitle("SignUp", "Create an Account!"),
                Center(
                  child: Container(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyTextFormField("Full Name", fullName),
                        MyTextFormField("Email", email),
                        MyTextFormField("Phone Number", phoneNumber),
                        MyTextFormField("Address", address),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isMale = !isMale;
                            });
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Color(0xfff5d8e4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              isMale == false ? "Female" : "Male",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        MyPasswordTextFormField("Password", password),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : MyButton("SignUp", () {
                        validation();
                      }),
                SizedBox(height: 10),
                HaveAccount(
                  "Already have an Account?",
                  "Login",
                  () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => Login(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
