import 'package:flutter/material.dart';
import 'package:animal_app/recordPage.dart';

import 'homePage.dart';
import 'linkPage.dart';
import 'mapPage.dart';
import 'matchPage.dart';

class Test3 extends StatefulWidget {
  const Test3({Key? key}) : super(key: key);

  @override
  State<Test3> createState() => _Test3State();
}

class _Test3State extends State<Test3> {
  final pages = [
    MatchPage(), //配對畫面
    RecordPage(), //紀錄畫面
    HomePage(), //首頁
    MapPage(), //地圖畫面
    LinkPage(), //連結畫面
  ]; //創建視圖數組
  int _currentIndex = 2; //數組索引，通過改變索引值改變視圖
  Color floating_action_button_color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
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
    );
  }

  void onClicked(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 2) {
        floating_action_button_color = Colors.white;
      } else {
        floating_action_button_color = Colors.black;
      }
    });
  }

}
