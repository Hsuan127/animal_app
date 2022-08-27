
import 'package:flutter/material.dart';

class MMWidget {

  // 建按鈕 
  static Widget newFlatButton( Widget child , VoidCallback callback )
  {
    return FlatButton(onPressed: callback, child: child) ;
  }
  // 建捲軸
  static Widget newScroll( Widget child , [Axis scrollDirection = Axis.vertical ] )
  {
    return new SingleChildScrollView(
        child : child ,
        //     physics: BouncingScrollPhysics(),
        //  controller: new ScrollController() ,
        scrollDirection : scrollDirection
    );
  }

  // dialng
  static Future<dynamic> showMessage( BuildContext context , final Widget child, [ List<Widget>? actions ] ) async
  {
    final dynamic result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (ctx)
      {
        return AlertDialog(
          content :  MMWidget.newScroll( child ),
          actions: actions ,
        );
      },
    );

    return result ;
  }


  // 建立單項框
  static Widget newRow(List<Widget> inList,
      [MainAxisAlignment? mainAxisAlignment = MainAxisAlignment.start,
        CrossAxisAlignment? crossAxisAlignment = CrossAxisAlignment.center]) {
    if (mainAxisAlignment == null) mainAxisAlignment = MainAxisAlignment.start;
    if (crossAxisAlignment == null)
      crossAxisAlignment = CrossAxisAlignment.center;

    return Row(
      children: inList,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize : MainAxisSize.max,
    );
  }

  // 建立單項框
  static Widget newRowSA(List<Widget> inList) {


    return Row(
      children: inList,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center ,
    );
  }

  ///
  static Widget newColumn(List<Widget> inList,
      [MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
        CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center]) {
    Widget ret = Column(
      children: inList,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize : MainAxisSize.min,
    );

    ret = Container( child: ret ,);
    return ret ;
  }

  /// 左上切齊
  static Widget newColumnSS(List<Widget> inList) {
    return newColumn(inList, MainAxisAlignment.start, CrossAxisAlignment.start);
  }

  static Widget newColumnEC(List<Widget> inList) {
    return newColumn(inList, MainAxisAlignment.end, CrossAxisAlignment.center);
  }

  // 左平
  static Widget newColumnAS(List<Widget> inList) {
    return Column(
      children: inList,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  static Widget newColumnAC(List<Widget> inList) {
    return Column(
      children: inList,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  static Widget newColumnBetween(List<Widget> inList,
      [CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center]) {
    return Column(
      children: inList,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAxisAlignment,
    );
  }

  static Widget newColumnAround(List<Widget> inList,
      [CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center]) {
    return Column(
      children: inList,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: crossAxisAlignment,
    );
  }

  // 建立一個 null 的 widget
  static Widget newNullWidget() {
    return new SizedBox.shrink();
  }

}