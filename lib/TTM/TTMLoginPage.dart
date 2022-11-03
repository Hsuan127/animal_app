
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MM/MM.dart';
import 'TTMUser.dart';

class TTMLoginPage extends StatefulWidget {

  @override
  _TTMLoginPage createState() => _TTMLoginPage();
}

class _TTMLoginPage extends State<TTMLoginPage>
{

  final TTMUser _user = TTMUser() ;
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _initPage();
  }

  Widget _initPage()
  {

    // 輸入
    Widget name = Container(
      //     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _userController,
        decoration: const InputDecoration(
          hintText: '請輸入帳號',
          labelText: '帳號',
        ),
      ),
    );

    // 上面的文字
    Widget pass = Container(
      // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        obscureText: true ,
        controller: _passController,
        decoration: const InputDecoration(
          hintText: '請輸入密碼',
          labelText: '密碼',
        ),
      ),
    );
    //
    //
    // 登入的文字
    Widget bnLogin = ElevatedButton(
      /*
        child: Align(
          alignment: Alignment.center,
          child: iChild, // 子物件
        ),*/
      child: Text( "登入" ),
      onPressed: onLogin,

      style: ElevatedButton.styleFrom(
        disabledForegroundColor: Colors.black12.withOpacity(0.38), disabledBackgroundColor: Colors.black12.withOpacity(0.12),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(12.0)),
      ),
      //   shape: AIFAWidget.newShape_RoundedRectangleBorder( 0.0 ), // 圓角的角度
    );

    //
    //
    Widget bnRegister = ElevatedButton(
      /*
        child: Align(
          alignment: Alignment.center,
          child: iChild, // 子物件
        ),*/
      child: Text( "註冊" ),
      onPressed: onRegister,

      style: ElevatedButton.styleFrom(
        disabledForegroundColor: Colors.black12.withOpacity(0.38), disabledBackgroundColor: Colors.black12.withOpacity(0.12),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(12.0)),
      ),
      //   shape: AIFAWidget.newShape_RoundedRectangleBorder( 0.0 ), // 圓角的角度

    );

    return Column( children: [
      name ,
      pass ,
      Row(  children: [
      bnLogin,
      bnRegister ,
      ])] );
  }
  //
 //
  void onLogin()
  {
    try
    {
      _user.onLogin( _userController.text ,
          _passController.text )..then((ret)
      {
        if( ret is String )
        {
          if( ret.isEmpty )
          {
            MM.pop( context );
          }
        }

        MM.MessageBox( context , ret.toString() );
      });
    }catch( e )
    {
    }
  }

  void onRegister()
  {
    final callback = ()async
    {
      try
      {
        _user.onRegister( _userController.text ,
            _passController.text ).then((ret)
        {
          if( ret is String )
          {
            if( ret.isEmpty )
            {
              MM.pop( context );
            }
          }

          MM.MessageBox( context , ret.toString() );
        });
      }catch( e )
      {
      }
    };
    callback();
  }
}
