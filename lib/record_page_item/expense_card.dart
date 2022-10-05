import 'package:flutter/material.dart';
import 'package:animal_app/record_page_item/add_expense.dart';

import '../MM/MM.dart';
import '../MM/MMWidget.dart';
import '../MMView/ExpenseStateView.dart';
import '../TTM/TTMItem.dart';
import '../TTM/TTMUser.dart';
import '../bottomAPPBar.dart';

/*

  花費明細


 */
class ExpenseCard extends StatelessWidget{
  final String balance;

  ExpenseCard( TTMUser user , TTMItem item , VoidCallback onCallback , {required this.balance}):
      _user = user ,
      _item = item ,
  _callback = onCallback

  ;

  final VoidCallback _callback ;
  final TTMUser _user ;
  final TTMItem _item;

  @override
  Widget build(BuildContext context){

    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
            children: <Widget>[

              // 金額
              _moneyPage(context),
              // 加入
              _addPage(context),
            ] )

    );
  }

  //
  // 錢，接下
  void _onMoneyClick( context )
  {
    MM.push(context, BottomAPPBar( 1 , child : ExpenseStateView( _item )));
  }
  // 錢
  Widget _moneyPage(context )
  {
    Widget ret =  Container(
      height: 150,
      width: 300,
      child: Center(
        child: Text(
            balance,
            style: TextStyle(fontFamily: 'Inter', color: Colors.amber[700], fontSize: 40, fontWeight: FontWeight.w700,)
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                offset: Offset(2, 2),
                blurRadius: 6.0,
                spreadRadius: 0),
            BoxShadow(
                color: Colors.white,
                offset: Offset(-2.0, -2.0),
                blurRadius: 6.0,
                spreadRadius: 0),
          ]),
    );

    // top
    ret = MMWidget.newTap(
        ret ,
        () => _onMoneyClick(context) , // click
    );
    return ret ;
  }

  //
  //
  // 加入接鈕
  Widget _addPage( context )
  {
    return              Positioned(
      bottom: 0.0,
      right: 0.0,
      child: FloatingActionButton(
          mini: true,
          heroTag: "uniqueTag",
          child: const Icon(Icons.add),
          onPressed: (){
            //      AddExpense.user = _user ;
            //      AddExpense.item = _item ;
            //        Navigator.pushNamedAndRemoveUntil(context, '/addExpense', (route) => false);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>BottomAPPBar( 1 , child: AddExpense( _user , _item )))).then((_)
            {
              _callback();
            });
/*
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddExpense( _user , _item ),
                          )).then((_)
                      {
                        _callback();
                      });*/
            /*
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddExpense(),
                          )).then((_)
                          {
                            _callback();
                          });*/
          }
      ),

    );

  }

}
