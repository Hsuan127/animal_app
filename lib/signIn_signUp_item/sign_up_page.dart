import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animal_app/signIn_signUp_item/sign_in_page.dart';
import 'package:animal_app/utils/color_utils.dart';
import 'package:animal_app/signIn_signUp_item/flutterfire.dart';

import 'color_utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _userNameValidate = false;
  bool _emailValidate = false;
  bool _passwordValidate = false;
  bool _confirmPasswordValidate = false;
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
          "註冊",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: hexStringToColor('FFC107'),
      body: //Container(
        Center(
          child: SingleChildScrollView(
            child: Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 190,
                    child: logoWidget("assets/images/iPet.png"),
                  ),
                  const SizedBox(
                    height: 10,
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
                      labelText: '請輸入姓名',
                      errorText: _userNameValidate ? '請記得輸入使用者名稱':null,
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
                      labelText: '請輸入帳號(信箱)',
                      errorText: _emailValidate ? '請記得輸入帳號':null,
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
                      labelText: '請輸入密碼',
                      errorText: _passwordValidate ? '請記得輸入密碼':null,
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
                      labelText: '請再次輸入密碼',
                      errorText: _confirmPasswordValidate ? '請記得再次輸入密碼':null,
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
                    setState(() {
                      _userNameTextController.text.isEmpty ? _userNameValidate = true : _userNameValidate = false;
                      _emailTextController.text.isEmpty ? _emailValidate = true : _emailValidate = false;
                      _passwordTextController.text.isEmpty ? _passwordValidate = true : _passwordValidate = false;
                      _confirmPasswordController.text.isEmpty ? _confirmPasswordValidate = true : _confirmPasswordValidate = false;
                    });
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()));
                      }
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      //),
    );
  }
}
