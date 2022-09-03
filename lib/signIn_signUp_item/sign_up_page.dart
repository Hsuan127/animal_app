import 'package:animal_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'color_utils.dart';
import 'flutterfire.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage ({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _userNameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool passwordConfirmed() {
    if (_passwordTextController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future addToFirestorage(String name, String email, String password) async {
    await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('personal details').add({
      'user_name': name,
      'email': email,
      'password': password,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: hexStringToColor('FFC107'),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    // new way of email text field
                    controller: _userNameTextController,
                    cursorColor: Colors.white10,
                    style: TextStyle(
                        color: hexStringToColor('ffffff').withOpacity(0.9)),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: hexStringToColor('ffffff'),
                      ),
                      labelText: 'Enter Your Name',
                      labelStyle: TextStyle(
                          color: hexStringToColor('ffffff').withOpacity(0.9)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: hexStringToColor('ffffff').withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: hexStringToColor('ffffff')),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    // new way of email text field
                    controller: _emailTextController,
                    cursorColor: Colors.white10,
                    style: TextStyle(
                        color: hexStringToColor('ffffff').withOpacity(0.9)),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: hexStringToColor('ffffff'),
                      ),
                      labelText: 'Enter Your Email',
                      labelStyle: TextStyle(
                          color: hexStringToColor('ffffff').withOpacity(0.9)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: hexStringToColor('ffffff').withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: hexStringToColor('ffffff')),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    // new way of email text field
                    controller: _passwordTextController,
                    obscureText: true,
                    cursorColor: Colors.white10,
                    style: TextStyle(
                        color: hexStringToColor('ffffff').withOpacity(0.9)),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: hexStringToColor('ffffff'),
                      ),
                      labelText: 'Enter Your Password',
                      labelStyle: TextStyle(
                          color: hexStringToColor('ffffff').withOpacity(0.9)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: hexStringToColor('ffffff').withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: hexStringToColor('ffffff')),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    // new way of email text field
                    controller: _confirmPasswordController,
                    obscureText: true,
                    cursorColor: Colors.white10,
                    style: TextStyle(
                        color: hexStringToColor('ffffff').withOpacity(0.9)),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: hexStringToColor('ffffff'),
                      ),
                      labelText: 'Enter Your Password Again',
                      labelStyle: TextStyle(
                          color: hexStringToColor('ffffff').withOpacity(0.9)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: hexStringToColor('ffffff').withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: hexStringToColor('ffffff')),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, false, () async {
                    if (passwordConfirmed()) {
                      bool isNavigator = await register(
                          _emailTextController.text,
                          _passwordTextController.text);
                      if (isNavigator) {
                        addToFirestorage(
                            _userNameTextController.text.trim(),
                            _emailTextController.text.trim(),
                            _passwordTextController.text.trim());
                        print("Created New Account");
                        Navigator.pushNamedAndRemoveUntil(context, '/homePage', (route) => false);
                      }
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
