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
      [Widget? inTitle = null, VoidCallback? onPressed = null , bool isNo = false , bool isYes = true ]) async {
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
            if( isYes )
              ElevatedButton(
                child: Text("確認"),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (null != onPressed) onPressed();
                },
              ),

            if( isNo )
              ElevatedButton(
                child: Text("取消"),
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
            ElevatedButton(
              child: Text(inOkStr ?? "確認"),
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


  // 多國語
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
  //
//

  // 新的 top
  static Widget newTap(Widget inChild,
      [VoidCallback? inCallback = null, VoidCallback? inLongCallback = null , VoidCallback? inDoubleCallback = null ])
  {
    if( null == inCallback )
      if( inLongCallback == null )
        if( inDoubleCallback == null )
          return inChild;

    return GestureDetector(
      child: inChild,
      onTap: inCallback,
      onLongPress: inLongCallback,
      onDoubleTap: inDoubleCallback ,
    );
  }

  //
  // edit dialog
  static Future<void> ShowEditDialog(
      var context,
      String text,
      Widget? inTitle,
      Function(String inText)? onPressed, [
        TextInputType? keyboardType,
        InputDecoration ?inputDecoration
      ]) async {
    final MaterialLocalizations materialLocalizations =
    MaterialLocalizations.of(context);
    // final InputDecoration input = new InputDecoration(labelText: 'Full Name', hintText: 'eg. John Smith');
    final TextEditingController input = new TextEditingController();
    input.text = text;
    //slideDialog.show
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: inTitle,
          content: SingleChildScrollView(
            child: new TextField(
              keyboardType: keyboardType,
              autofocus: true,
              controller: input,
              decoration: inputDecoration,

            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("確認"),
              onPressed: () {
                // test
                final String text = input.text.trim() ;
                // null ，就不處理了
                if( text.isEmpty )
                {
                  MM.MessageBox( context , "未輸入任何文字", "輸入錯誤" );
                  return ;
                }
                //
                if (null != onPressed)
                {
                  final ret = onPressed( text );
                  if( ret is bool )
                    if( ret == false )
                      return ;
                }
                Navigator.of(context).pop( text );
              },
            ),
            ElevatedButton(
              child: Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  ///
  static Widget newColumn(List<Widget> inList,
      [
        MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceEvenly,
        CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center
      ]) {
    return Column(
      children: inList,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
    );
  }


  ///
  static Widget newRow(List<Widget> inList,
      [MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
        CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center]) {
    return Row(
      children: inList,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
    );
  }

  // 建立滑動
  //   直式
  static Widget newScrollVertical(Widget inChild,
      [ScrollController? controller]) {
    return newScroll(inChild, true, controller);
  }

  static Widget newColumnScroll(List<Widget> inChild) {
    return newScrollVertical(newColumn(inChild));
    //return newScroll( inChild , true );
  }

  ///   橫式
  static Widget newScrollHorizontall(Widget inChild) {
    return newScroll(inChild, false);
  }

  static Widget newScroll(Widget inChild, [bool isVertical = true ,
      ScrollController? controller , bool physics = false ]) {
    Axis axis = (isVertical) ? Axis.vertical : Axis.horizontal;
    return SingleChildScrollView(
        scrollDirection: axis,
        controller: controller,
        physics: physics ? ClampingScrollPhysics() : null ,
        //  physics: AlwaysScrollableScrollPhysics()  ,
        //   reverse :true ,
        child: inChild);
  }

  //
  //
  static Widget newOutlinedButton( String text , VoidCallback? onPressed , [ double width = 100 , double height = 100 , Color? backgroundColor , double borderRadius = 15 , Color? primary , Widget ?icon ] )
  {
    //
    if( icon == null )
      icon = SizedBox.shrink();


    //
    return OutlinedButton.icon(
      onPressed: onPressed ,
      icon: icon ,// const Icon(Icons.vaccines),
      label: Text( text ),
      style: OutlinedButton.styleFrom(
        backgroundColor : backgroundColor ,
        fixedSize: Size(width, height),
        primary: primary ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }


  static Widget newElevatedButton( String text , VoidCallback? onPressed ,
      [  double textSize = 20 , Color ? backgroundColor , VoidCallback? onLongPress , ] )
  {
    //
    return  ElevatedButton(
      onPressed: onPressed ,
      child: Text(text, style: TextStyle(fontSize: textSize),),
      style: ElevatedButton.styleFrom(  primary : backgroundColor ,),
    );
  }
}