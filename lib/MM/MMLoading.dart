
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MMDialogRouter extends PageRouteBuilder
{

  final Widget page;

  MMDialogRouter(this.page)
      : super(
    opaque: false,
    barrierColor: Color(0x80000000),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
  );
}

class MMLoading {

  static void show(BuildContext context ) {
    print( "MMLoading:show" );
    Navigator.of(context)
        .push(MMDialogRouter(MMLoadingDialog()));
  }

  static void hide(BuildContext context) {
    print( "MMLoading:hide" );
    Navigator.of(context).pop();
  }
}

class MMLoadingDialog extends Dialog {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Material(
          type: MaterialType.transparency,
          child: Center(

            child: Container( child : CupertinoActivityIndicator(
              radius: 18,
            ),
              color: Colors.white54 ,
            ),
          ),
        ),
        onWillPop: () async {
          return Future.value(false);
        });
  }
}