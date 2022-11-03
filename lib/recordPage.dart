import 'package:animal_app/TTM/TTMItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animal_app/record_page_item/expense_card.dart';
import 'package:animal_app/record_page_item/estimate_card.dart';
import 'package:animal_app/record_page_item/health_condition.dart';

import 'MM/HYSizeFit.dart';
import 'MM/MM.dart';
import 'TTM/TTMLoginPage.dart';
import 'TTM/TTMUser.dart';


class RecordPage extends StatefulWidget {
  int selectedIndex=0;//will highlight first item
  RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage>{

  List<String> _myList=[];


  int _selectedIndex=0;
  int _spend = 0 ;
  @override
  Widget build(BuildContext context)
  {
    HYSizeFit.initialize(context);
    Widget c = Text( "尚未登入... " );
    if( _auth.currentUser != null )
      c = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 40, // play with height
              child:_petListPage()
          ),

          Divider(
            color: Colors.grey[400],
            height: 40,
            thickness: 2,
          ),

          // 寵物頁
          _petPage(),
        ],
      );

    return Scaffold(
      resizeToAvoidBottomInset: false ,
      appBar: AppBar( title: const Center( child:  const Text('紀錄') ),
   //     actions: _appBarActions(),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(50.0),
        child: c ,
      ),
    );



  }

  //
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signIn();
  }
  //
  //

  // 下月花費
  int _nextMonthMoney = 0 ;
  // 名稱列表
  bool _isLoading = false  ;
  Widget _petListPage()
  {
    if( _isLoading)
      return CircularProgressIndicator();

    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => SizedBox(width: 20,),
      itemCount: _myList.length + 1 , //number of item you like show
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        String str = "+" ;
        final id = index ;
        if( id < _myList.length ) {
       //   str = "${id + 1}";
            str = _myList[id].substring( 0 , 1 );
        }



        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _onSelect( id ),
            onLongPress: () => onRemove( id ),
            child: Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color:
                _selectedIndex == index ? Colors.amber : Colors.grey[400],
              ),
              child: Text( str ),
            ),
          ),
        );
      },
    );
  }
  //
  // 資料
  Widget _petPage()
  {
    try
    {

      TTMItem item = _user.getAt( _selectedIndex );
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        // --------------------------------------------
        // 名稱
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(item.name ,
                style: TextStyle(fontSize: 20, backgroundColor: Colors.amber)
            ),
          ),
        ),
          SizedBox(
            height: 10,
          ),
        // --------------------------------------------
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text('本月總花費',
                style: TextStyle(fontSize: 20,)
            ),
          ),
        ),
        ExpenseCard(
          _user , _user.getAt( _selectedIndex ),
              (){
            _initSpend( _selectedIndex ) ;
            },
          balance: "\$ ${item.money}",
        ),
        SizedBox(
          height: 10,
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text('下個月日常性花費預估',
                style: TextStyle(color: Colors.grey[600], fontSize: 12)
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),

        ExpectCard(
            expectation:  "\$ ${item.nextMoney}"
        ),
          SizedBox(
            height: 10,
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text('健康狀態',
                style: TextStyle(fontSize: 20,)
            ),
          ),
        ),
          SizedBox(
            height: 10,
          ),
        HealthCondition( _user ,  _user.getAt( _selectedIndex )),

      ],
      );

    }catch( e )
    {
      if( _auth.currentUser == null )
        return Text( "尚未登入..." );
      if( _isLoading )
        return Text( "努力加載紀錄中..." );
      return Text( "error:$e" );
    }
  }

  //
  Future<void> _signOut() async {
    _myList = [] ;
    setState(() {

    });
    await _auth.signOut();
    _user.signOut();
    await _initData();
  }
  //
  Future<void> _signIn() async {
    User?user = _auth.currentUser ;
    if( user != null )
    {

      _initData();
      return ;
    }/*
    await _auth.signInWithEmailAndPassword(
        email: "ttm_test@gmail.com" ,
        password: "123456" );
    user = _auth.currentUser ;
    if( user == null )
    {
      MM.MessageBox( context , "無法登入" );
      return ;
    }

    _initData();*/

  }

  final TTMUser _user = TTMUser() ;
  //
  Future<void> _initData() async
  {

    setState(() => _isLoading = true );

    try
    {
      _selectedIndex = 0 ;
      await _user.readData();
      _myList =  _user.bufList();
      await _initSpend( _selectedIndex );


    }catch( e )
    {
      print( e.toString());
    }


    setState(() => _isLoading = false  );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 右上按鈕
  List<Widget> _appBarActions()
  {
    User?user = _auth.currentUser ;
    List<Widget> ret = [] ;
    if( user == null ) {
      ret.add( MM.newTap( Center( child : Text( "登入" ,  style: Theme.of(context).textTheme.titleLarge ,)) ,
              () => _onLogin()
      ));
    } else
    {
      ret.add( MM.newTap( Center( child : Text( "登出" ,  style: Theme.of(context).textTheme.titleLarge ,) ),
              (){ _signOut(); }
      ));
    }

    return ret ;
  }
  //
  // 登入
  void _onLogin()
  {
    TTMLoginPage loginPage = TTMLoginPage();
    MM.ShowDialog( context , loginPage , null , null , false , false  ).then((_)
    {
      _initData();
    });
  }
  //
  //
  Future<void> _initSpend( final int index )async
  {
    try
    {
      TTMItem item = _user.getAt( index );
      _spend = await item.getSpend();
      _selectedIndex = index;

      setState(()
      {
      });
    }catch( e )
    {
    }
  }
  //
  //
  Future<void> _onAdd( String name )async
  {
    try
    {
      await _user.addData( new TTMItem(  null , "" , name , 0 ));
      _myList =  _user.bufList();
      setState(() {

      });
    }catch( e )
    {
    }
  }
  // 點下
  void _onSelect( final int index )
  {

    if( index < _myList.length )
    {
      _selectedIndex = index ;
      _initSpend( index );
      return ;
    }
    // 新增
    try
    {

      MM.ShowEditDialog( context , "" , Text( "您的毛寶貝大名？" ) , (text)
      {
        if( text is String )
          _onAdd( text );
      });
    }catch( e )
    {
    }
  }

  // remove

  void onRemove(int id)
  {

    try
    {

      TTMItem item = _user.getAt( id );
      // 移除
      final removeCallback = () async
      {
        String ret = await _user.removePie( item );
        MM.MessageBox( context , ret , null , () => _initData()
        );
      };
      //
      MM.ShowDialog( context
          , Text( "確定要刪除 ${item.name} 的資料嗎？" )
          , null
          , ()=>removeCallback()
          , true
          , true
      );

    }catch( e )
    {
      MM.MessageBox( context , e.toString() );
    }
  }
}
