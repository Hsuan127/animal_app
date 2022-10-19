import 'package:flutter/material.dart';
import 'package:animal_app/homePage.dart';
import 'package:animal_app/matchFavPage.dart';
import 'package:animal_app/matchFilterPage.dart';
import 'package:animal_app/matchPage.dart';
import 'package:animal_app/recordPage.dart';
import 'package:animal_app/mapPage.dart';
import 'package:animal_app/linkPage.dart';
import 'package:animal_app/record_page_item/add_expense.dart';
import 'package:animal_app/record_page_item/add_vaccine.dart';
import 'package:animal_app/record_page_item/add_doctor.dart';
import 'package:animal_app/record_page_item/condition.dart';
import 'package:animal_app/record_page_item/weight_record.dart';
import 'package:animal_app/record_page_item/shit_record.dart';
import 'package:animal_app/record_page_item/activity_record.dart';
import 'package:animal_app/record_page_item/diet_record.dart';

class BottomAPPBar extends StatefulWidget {
  int i = 0;
  Widget? _child ;

  BottomAPPBar(this.i, { Widget? child , Key? key}) :
        super(key: key)
  {
    _child = child ;
  }

  @override
  State<BottomAPPBar> createState() => _BottomAPPBarState( _child );
}

class _BottomAPPBarState extends State<BottomAPPBar> {
  Widget? _child ;
  _BottomAPPBarState( this._child );

  //創建視圖數組
  final pages = [
    MatchPage(), //配對頁面
    RecordPage(), //紀錄頁面
    HomePage(), //首頁
    MapPage(), //地圖頁面
    LinkPage(), //連結頁面
    MatchFilterPage(), //配對-篩選頁面
    MatchFavPage(), //配對-我的最愛頁面
//    AddExpense(),
  ];

  int _currentIndex = 2; //bottom APP Bar的選擇變換
  int _pageNumber = 2; //body的page變換
  Color floating_action_button_color = Colors.white;

  void initState() {
    super.initState();
    if (widget.i < 5) {
      _currentIndex = widget.i;
      _pageNumber = widget.i;
    } else {
      _currentIndex = 0;
      _pageNumber = widget.i;
    }
    if (_currentIndex == 2) {
      floating_action_button_color = Colors.white;
    } else {
      floating_action_button_color = Colors.black;
    }
  }

  void onClicked(int index) {
    setState(() {
      _child = null ;
      if (index < 5) {
        _currentIndex = index;
        _pageNumber = index;
      } else {
        _currentIndex = 0;
        _pageNumber = index;
      }
      if (_currentIndex == 2) {
        floating_action_button_color = Colors.white;
      } else {
        floating_action_button_color = Colors.black;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body = pages[_pageNumber] ;
    if( _child != null )
      body = _child! ;
    return Scaffold(
      //添加索引，顯示對應界面
      body: body ,// pages[_pageNumber],
      resizeToAvoidBottomInset : false ,
      // //添加一個懸浮按鈕home
      // floatingActionButton: Container(
      //   height: MediaQuery.of(context).size.width * 0.18,
      //   width: MediaQuery.of(context).size.width * 0.18,
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.width * 0.18,
        width: MediaQuery.of(context).size.width * 0.18,
        child: FittedBox(
          child:FloatingActionButton(
            onPressed: () {
              onClicked(2);
            }, //按鈕點擊事件
            tooltip: '回到首頁', //按鈕長按提示
            child: Icon(
              Icons.home_filled,
              size: 36.0,
            ),
            foregroundColor: floating_action_button_color,
            backgroundColor: Colors.amber,
            elevation: 0,
          ),
        ),
      ),

      //懸浮按鈕和底部工具欄進行融合
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //添加底部5個切換功能match,record,home,map,link
      // bottomNavigationBar: BottomAppBar(
      //     shape: const CircularNotchedRectangle(),
      //     notchMargin: 4.0,
      //     color: Colors.orange,
      //     elevation: 0,
      //   child: Row( //children inside bottom appbar
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       Column(
      //         children: <Widget>[
      //           IconButton(icon: Icon(Icons.volunteer_activism_outlined, color: Colors.black,), onPressed: () {},),
      //           Text("配對", style: TextStyle(fontSize: 12, color: Colors.black),)
      //       ]
      //       ),
      //       Column(
      //           children: <Widget>[
      //             IconButton(icon: Icon(Icons.receipt_long_outlined, color: Colors.black,), onPressed: () {},),
      //             Text("紀錄", style: TextStyle(fontSize: 12, color: Colors.black),)
      //           ]
      //       ),
      //       Column(
      //           children: <Widget>[
      //             IconButton(icon: Icon(Icons.place_outlined, color: Colors.black,), onPressed: () {},),
      //             Text("地圖", style: TextStyle(fontSize: 12, color: Colors.black),)
      //           ]
      //       ),
      //       Column(
      //           children: <Widget>[
      //             IconButton(icon: Icon(Icons.link_outlined, color: Colors.black,), onPressed: () {},),
      //             Text("連結", style: TextStyle(fontSize: 12, color: Colors.black),)
      //           ]
      //       ),
      //     ],
      //   ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.085,
        child:BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.amber[700],
          showUnselectedLabels: true,
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          unselectedLabelStyle: TextStyle(fontStyle: FontStyle.normal, fontSize: 12),
          selectedIconTheme: IconThemeData (
              color: Colors.white,
              opacity: 1.0,
              size: 25
          ),
          unselectedIconTheme: IconThemeData (
              color: Colors.black,
              opacity: 0.8,
              size: 20
          ),
          unselectedItemColor: Colors.black,
          onTap: onClicked,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.volunteer_activism_outlined,
              ),
              label: '配對',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.receipt_long_outlined,
              ),
              label: '紀錄',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                color: Colors.amber[700],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.place_outlined,
              ),
              label: '地圖',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.link_outlined,
              ),
              label: '連結',
            ),
          ],
        ),
      ),
    );
  }
}