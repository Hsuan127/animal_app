import 'package:animal_app/main.dart';
import 'package:animal_app/signIn_signUp_item/reset_password.dart';
import 'package:animal_app/signIn_signUp_item/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../bottomAPPBar.dart';
import '../homePage.dart';
import 'color_utils.dart';
import 'flutterfire.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isPasswordType = true;
  bool _emailvalidate = false;
  bool _passwordvalidate = false;

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    /*
    if( FirebaseAuth.instance.currentUser != null )
      {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) =>  BottomAPPBar(0))) ;

      }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hexStringToColor('FFC107'),
        body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 190,
                      child: logoWidget("assets/images/iPet.png"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextField(
                      // new way of email text field
                      controller: _emailTextController,
                      cursorColor: Colors.white10,
                      style: TextStyle(
                          color: hexStringToColor('ffffff').withOpacity(0.9)),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: hexStringToColor('ffffff'),
                        ),
                        labelText: '請輸入帳號',
                        errorText: _emailvalidate ? '請記得輸入帳號' : null,
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
                    SizedBox(
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
                        errorText: _passwordvalidate ? '請記得輸入密碼' : null,
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
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ResetPasswordScreen();
                                  }),
                                );
                              },
                              child: Text(
                                '忘記密碼？',
                                style: TextStyle(
                                    color: hexStringToColor('212121'),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    signInSignUpButton(context, true, () async {
                      setState(() {
                        _emailTextController.text.isEmpty
                            ? _emailvalidate = true
                            : _emailvalidate = false;
                        _passwordTextController.text.isEmpty
                            ? _passwordvalidate = true
                            : _passwordvalidate = false;
                      });
                      bool isNavigator = await signIn(
                          _emailTextController.text.trim(),
                          _passwordTextController.text.trim());
                      if (isNavigator) {
                        print("Successfully Signed In");
                        Navigator.pushNamedAndRemoveUntil(context, '/homePage',  (route) => false);
                      }
                    }),
                    signUpOption(),
                  ],
                ),
              ),
            ),
        ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "還沒註冊嗎？",
          style: TextStyle(color: hexStringToColor('212121')),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
          child: Text(
            "註冊按這邊",
            style: TextStyle(
                color: hexStringToColor('212121'), fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
