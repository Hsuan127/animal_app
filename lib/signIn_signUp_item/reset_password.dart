import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'color_utils.dart';



class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  bool _emailTextValidate = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      setState(() {
        _emailTextController.text.isEmpty
            ? _emailTextValidate = true
            : _emailTextValidate = false;
      });
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailTextController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content:
              Text('驗證信已送出！請至${_emailTextController.text.trim()}收信並修改密碼！'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.message == 'The email address is badly formatted.') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('親愛的使用者，請確認您的Email帳號是否正確'),
              );
            });
      }
      if (e.message ==
          'There is no user record corresponding to this identifier. The user may have been deleted.') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('親愛的使用者，您不是使用此信箱註冊iPet，請再試試其他Email'),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('忘記密碼'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: hexStringToColor('FFC107'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '請輸入您所註冊的Email，稍後我們將會寄信給您，請您重新設定密碼',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            // new way of email text field
            controller: _emailTextController,
            cursorColor: Colors.white10,
            style:
            TextStyle(color: hexStringToColor('ffffff').withOpacity(0.9)),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: hexStringToColor('ffffff'),
              ),
              labelText: '帳號',
              errorText: _emailTextValidate ? '請輸入帳號' : null,
              labelStyle:
              TextStyle(color: hexStringToColor('ffffff').withOpacity(0.9)),
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: hexStringToColor('ffffff').withOpacity(0.3),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                  const BorderSide(width: 0, style: BorderStyle.none)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: hexStringToColor('ffffff')),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: passwordReset,
            child: Text(
              '送出',
              style: TextStyle(
                  color: hexStringToColor('212121'),
                  fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.black26;
                  }
                  return hexStringToColor('FFECB3');
                }),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)))),
          )
        ],
      ),
    );
  }
}