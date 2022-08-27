import 'package:flutter/material.dart';
import 'package:animal_app/homePage.dart';
import 'package:animal_app/matchPage.dart';
import 'package:animal_app/recordPage.dart';
import 'package:animal_app/mapPage.dart';
import 'package:animal_app/linkPage.dart';

class BottomAPPBar extends StatefulWidget {
  const BottomAPPBar({Key? key}) : super(key: key);

  @override
  State<BottomAPPBar> createState() => _BottomAPPBarState();
}

class _BottomAPPBarState extends State<BottomAPPBar> {
  final pages = [
    MatchPage(),
    RecordPage(),
    HomePage(),
    MapPage(),
    LinkPage(),
  ]; //創建視圖數組
  int _currentIndex = 0; //數組索引，通過改變索引值改變視圖
  Color floating_action_button_color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_currentIndex], //添加索引，顯示對應界面
        //添加一個懸浮按鈕
        floatingActionButton: Container(
          height: 100,
          width: 100,
          child: FittedBox(
          child: FloatingActionButton(
          onPressed: () {
            onClicked(2);
            floating_action_button_color = Colors.white;
          }, //按鈕點擊事件
          tooltip: '回到首頁', //按鈕長按提示
          child: Icon(Icons.home_filled,),
          foregroundColor: floating_action_button_color,
        ),
        ),
        ),

        //懸浮按鈕和底部工具欄進行融合
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        //改
        bottomNavigationBar: SizedBox(height:80,
            child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.amber[700],
          showUnselectedLabels: true,
          fixedColor: Colors.white,
          selectedFontSize: 16,
          unselectedItemColor: Colors.black,
          unselectedFontSize: 16,
          onTap: onClicked,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.volunteer_activism_outlined,), label: '配對',),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined,), label: '紀錄',),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, color: Colors.amber[700],), label: '',),
            BottomNavigationBarItem(
              icon: Icon(Icons.place_outlined,), label: '地圖',),
            BottomNavigationBarItem(icon: Icon(Icons.link_outlined,), label: '連結',),
          ],
        ),
    ),
    );
  }

  void onClicked(int index){
    setState(() {
      _currentIndex = index;
      floating_action_button_color = Colors.black;
    });
  }

}
