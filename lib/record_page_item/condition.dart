import 'package:animal_app/MM/HYSizeFit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../MM/MM.dart';
import '../MM/MMWidget.dart';
import '../MM/MMWidgetSelect.dart';
import '../MMView/ActivityCardStateView.dart';
import '../MMView/FoodCardStateView.dart';
import '../MMView/ShitCardStateView.dart';
import '../MMView/WeightCardStateView.dart';
import '../TTM/TTMItem.dart';
import '../TTM/TTMPieCondition.dart';

class Condition extends StatelessWidget{
  Condition( this.item , {Key? key}) : super(key: key);
  final TTMPieCondition pieCondition = TTMPieCondition() ;
  final TTMItem item ;

  @override
  Widget build(BuildContext context) {

    //
    Widget body = Center(
      child: MM.newColumn([
        WeightCard(this.item, pieCondition.getDatas(0)),
        ShitCard(this.item, pieCondition.getDatas(1)),
        ActivityCard(this.item,pieCondition.getDatas(2)),
        DietCard( this.item , pieCondition.getDatas(3)),
      ]));
      
      //
    body = Padding(padding: EdgeInsets.all( 20 ) ,
      child: body ,);
    

      return Scaffold(
          resizeToAvoidBottomInset: false ,
          appBar: AppBar(
              centerTitle : true ,

            title: const  Text('健康狀態' ),
            /*
            title: const Center( child:  const Text('健康狀態') ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),*/
          ),
          body: body ,
            /*
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeightCard(),
              ShitCard(),
              ActivityCard(),
              DietCard(),
            ],
          ),*/


      );
    }

}

// 體重紀錄
class WeightCard extends StatefulWidget{

  WeightCard( this.item , this.data );
  final List<TTMPieConditionItem> data ;
  final TTMItem item ;


  //const WeightCard({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _WeightCardState(this.item , this.data);
  }
}


class _WeightCardState extends State<WeightCard>
    with WidgetsBindingObserver
{

  _WeightCardState( this.item , this.data );
  final List<TTMPieConditionItem> data ;
  final TTMItem item ;

  // 體重
  // 花費金額
  final TextEditingController _expenseController = TextEditingController();

  // 載入中
  bool _isLogin = true ;
  @override
  void initState()
  {
    _initState();
  }
  Future<void> _initState() async
  {
    _isLogin = true ;
    setState((){});

    await this.item.initTodayWeight();
    _isLogin = false ;
    _expenseController.text = this.item.todayWeight.toString();
    setState((){});
  }

  @override
  Widget build(BuildContext context){

    Widget ret ;
    DateTime dateTime = DateTime.now();
    String str = "${dateTime.month}/${dateTime.day}" ;

    // 轉轉
    String  weightStr = "今日尚未紀錄" ;
    if( this.item.todayWeight > 0 )
      weightStr = "${this.item.todayWeight}kg" ;
    Widget c ;
    if( _isLogin ) {
      c = CircularProgressIndicator();
    } else {
      c = Text( weightStr , style:  TextStyle(fontSize: 24,));
      c = Padding( child: c, padding : EdgeInsets.all(2.piw));
    }


    // 加框
    c = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        c ,
      ],);
    /*
    if( data.isNotEmpty )
      str = data[0].toString();
*/
 //   return SizedBox.shrink();
    ret = Container(
     //   width: 320,
      //  height: 125,
        child: Card(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text('體重', style: TextStyle(fontSize: 24,)),

                    TextButton(
                      onPressed: (){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => WeightCardStateView( this.item , this.data )))
                              .then((value)
                              {
                                setState(() {

                                });
                              }
                          ) ;
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child:  Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Text(str, style: TextStyle(fontSize: 16, fontFamily: 'Inter', color: Colors.grey[600])),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 30,
                          ),
                        ],
                      ),

                    ),

                  ],
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: c // Text('20kg', style: TextStyle(fontSize: 32,)),

                )

              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          elevation: 10,

        ),
    );

    // 加一層
//    ret = Padding(padding: EdgeInsets.only( top : 40 ) ,
//      child:  ret ,);
    // 結束
    return ret ;

  }
}

// 大便狀況紀錄
class ShitCard extends StatefulWidget{

  ShitCard( this.item , this.data );
  final List<TTMPieConditionItem> data ;
  final TTMItem item ;

  //const WeightCard({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _ShitCardState( this.item , this.data );
  }
}
class _ShitCardState extends State<ShitCard>{

  _ShitCardState( this.item , this.data );
  final List<TTMPieConditionItem> data ;
  final TTMItem item ;
  final _values = TTMItem.shitName ;//[ "正常", "腹瀉" ,"便秘" ];

  // 載入中
  bool _isLogin = true ;
  @override
  void initState()
  {
    _initState();
  }
  Future<void> _initState() async
  {
    _isLogin = true ;
    setState((){});

    await this.item.initTodayShit();
    _isLogin = false ;
    setState((){});
  }


  @override
  Widget build(BuildContext context){

    DateTime dateTime = DateTime.now();
    String str = "${dateTime.month}/${dateTime.day}" ;

    // 轉轉
    Widget c ;
    String  string = "今日尚未紀錄" ;
    try
    {
      if( _values.indexOf(this.item.todayShit ) >= 0 )
        string = this.item.todayShit ;
    }catch(_){};

    if( _isLogin )
      c = CircularProgressIndicator();
    else {
      c = Text( string , style:  TextStyle(fontSize: 24,));
      c = Padding( child: c, padding : EdgeInsets.all(2.piw));
    }





          //
    return Container(
    //  width: 320,
    //  height: 125,
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text('大便狀況', style: TextStyle(fontSize: 24,)),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => ShitCardStateView( this.item , this.data )))
                          .then((value)
                      {
                        setState(() {

                        });
                      }
                      ) ;
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(str, style: TextStyle(fontSize: 16, fontFamily: 'Inter', color: Colors.grey[600],)),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 30,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: c //Text('正常', style: TextStyle(fontSize: 32,)),
                ),


            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,

      ),
    );


  }
}

// 活動量紀錄
class ActivityCard extends StatefulWidget{
  ActivityCard( this.item , this.data );
  final List<TTMPieConditionItem> data ;
  final TTMItem item ;



  //const WeightCard({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _ActivityCardState(this.item ,this.data );
  }
}
class _ActivityCardState extends State<ActivityCard>
    with WidgetsBindingObserver
{
  _ActivityCardState( this.item , this.data );
  final List<TTMPieConditionItem> data ;
  final TTMItem item ;

  final _values = TTMItem.activityName ;// [ "高" , "中" , "低" ];

  // 載入中
  bool _isLogin = true ;
  @override
  void initState()
  {
    _initState();
  }
  Future<void> _initState() async
  {
    _isLogin = true ;
    setState((){});

    await this.item.initTodayActivity();
    _isLogin = false ;
    setState((){});
  }
  //
  //
  //
  @override
  Widget build(BuildContext context){

    DateTime dateTime = DateTime.now();
    String str = "${dateTime.month}/${dateTime.day}" ;

    // 轉轉
    Widget c ;
    String  string = "今日尚未紀錄" ;
    try
    {
      if( _values.indexOf(this.item.todayActivity ) >= 0 )
        string = this.item.todayActivity ;
    }catch(_){};

    if( _isLogin )
      c = CircularProgressIndicator();
    else {
      c = Text( string , style:  TextStyle(fontSize: 24,));
      c = Padding( child: c, padding : EdgeInsets.all(2.piw));
    }


    return Container(
  //    width: 320,
  //    height: 125,
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('活動量', style: TextStyle(fontSize: 24,)),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => ActivityCardStateView( this.item , this.data )))
                          .then((value)
                      {
                        setState(() {

                        });
                      }
                      ) ;
                    },

                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(str, style: TextStyle(fontSize: 16, fontFamily: 'Inter', color: Colors.grey[600])),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 30,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child:c
              )
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,

      ),
    );


  }
}

// 飲食狀況紀錄
class DietCard extends StatefulWidget{
  DietCard( this.item , this.data );
  final List<TTMPieConditionItem> data ;
  final TTMItem item ;

  //const WeightCard({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _DietCardState( this.item , this.data );

  }
}
class _DietCardState extends State<DietCard>{
  _DietCardState( this.item , this.data );
  final List<TTMPieConditionItem> data ;
  final TTMItem item ;

  final _values = TTMItem.foodName ;//[ "正常" , "偏少" , "偏多" ];

  // 載入中
  bool _isLogin = true ;
  @override
  void initState()
  {
    _initState();
  }
  Future<void> _initState() async
  {
    _isLogin = true ;
    setState((){});

    await this.item.initTodayFood();
    _isLogin = false ;
    setState((){});
  }


  @override
  Widget build(BuildContext context){
    DateTime dateTime = DateTime.now();
    String str = "${dateTime.month}/${dateTime.day}" ;


    // 轉轉
    Widget c ;
    String  string = "今日尚未紀錄" ;
    try
    {
      if( _values.indexOf(this.item.todayFood ) >= 0 )
        string = this.item.todayFood ;
    }catch(_){};

    if( _isLogin )
      c = CircularProgressIndicator();
    else {
      c = Text( string , style:  TextStyle(fontSize: 24,));
      c = Padding( child: c, padding : EdgeInsets.all(2.piw));
    }

    return Container(
    //  width: 320,
    //  height: 125,
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('飲食狀況', style: TextStyle(fontSize: 24,)),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => FoodCardStateView( this.item , this.data )))
                          .then((value)
                      {
                        setState(() {

                        });
                      }
                      ) ;
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text( str , style: TextStyle(fontSize: 16, fontFamily: 'Inter', color: Colors.grey[600])),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 30,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: c ,
              )

            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,

      ),
    );


  }
}