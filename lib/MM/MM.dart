// TODO Implement this library.
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';


class MM
{
  // sleep
  static void Sleep(int milliseconds )
  {
    sleep(Duration( milliseconds:milliseconds ));
  }
  static Future<void> SleepAsync(int milliseconds ) async
  {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  // 判斷，沒有就加入
  static void checkAdd(List<String> outBuf , List<String> inBuf )
  {
    for( final d in inBuf )
      {
        if( outBuf.indexOf( d ) < 0 )
          outBuf.add( d );
      }
  }

  //
  static double getScreenHeight( context )
  {
    return MediaQuery.of(context).size.height ;
  }

  static double getScreenWidth( context )
  {
    return MediaQuery.of(context).size.width ;
  }

  static void pop(BuildContext context ,[ dynamic ret ])
  {
    Navigator.of(context).pop( ret );
  }

  static push(BuildContext context , page )
  {
    return Navigator.push( context , MaterialPageRoute(builder: (context) => page ));
  }

  //
  // index
  static int strListIndex( List<String?> strBuf , String inStr )
  {
    String ret = "" ;
    int i ;
    for( i = 0 ; i < strBuf.length ; ++i  )
      {
        final String? str0 = strBuf[i] ;
        if( str0 != null )
          if( 0 == str0.indexOf( inStr ))
            return i ;
      }
    return -1 ;
  }

  static List<String> strListGet( List<String?> strBuf , int inStart , [ int inEnd = -1]  )
  {
    List<String> ret =[] ;
    int i ;
    for( i = inStart ;( i < strBuf.length ); ++i  )
    {
      if( inEnd > 0 ) if( i >= inEnd )
        break ;
      final String? str0 =  strBuf[i] ;
      if( str0 != null )
        ret.add( str0 );
    }
    return ret ;
  }
  //
  static String strListToString( List<String?> list )
  {
    String ret = "" ;
    for( final String? str in list )
    {
      if( str == null )
        continue ;
      if( str.isEmpty )
      continue ;
      {
        ret += str ;
      }
      ret += "\n" ;
    }
    return ret ;
  }


  // ------------------------------------------------
  // 彈出
  static Future<void> ShowDialog(var context, Widget? inChild,
      [Widget? inTitle = null, VoidCallback? onPressed = null , bool isNo = false ]) async {
    //slideDialog.show
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: inTitle,
          content: SingleChildScrollView(
            child: inChild,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(MM.strOk(context)),
              onPressed: () {
                Navigator.of(context).pop();
                if (null != onPressed) onPressed();
              },
            ),

            if( isNo )
              FlatButton(
                child: Text(MM.strCancel(context)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
          ],

        );
      },
    );
  }

  // ----------------------
  static Future<void> MessageBox(var context, String inMSG,
      [String? inTitle = null,
        VoidCallback? callback = null,
        String? inOkStr]) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (inTitle == null) ? null : Text(inTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(inMSG),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(inOkStr ?? MM.strOk(context)),
              onPressed: () {
                Navigator.of(context).pop();
                if (null != callback) callback();
              },
            ),
          ],
        );
      },
    );
  }


  // 多國語語
  static String strOk(context) {
    return MaterialLocalizations.of(context).okButtonLabel;
  }

  static String strCancel(context) {
    return MaterialLocalizations.of(context).cancelButtonLabel;
  }

/*
  // 權限
  static Future<void> checkPermission() async
  {
    var status = await Permission.camera.status;
    if (status.isDenied)
    {
      if (await Permission.contacts.request().isGranted) {
       return ;
      }

// You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
        Permission.camera ,
      ].request();
      print(statuses[Permission.storage]);
      print(statuses[Permission.location]);
      print(statuses[Permission.camera]);
    }

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
    }
  }*/
//
  static String strSubTo( String str ,[  String key = "-({[ " , int maxLen = 20  ] )
  {
    int i ;
    for( i = 0 ; i < key.length ; ++i )
    {
      int index = str.indexOf( key[i] );
      if( index > 0 )
        str = str.substring( 0 , index );
    }
    int len = str.length ;
    if( len < maxLen )
      return str ;
    return str.substring( 0 ,  ( maxLen - 3 ) ) + " ..." ;
  }
}