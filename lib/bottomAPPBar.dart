import 'package:flutter/material.dart';
import 'package:animal_app/homePage.dart';
import 'package:animal_app/matchFavPage.dart';
import 'package:animal_app/matchFilterPage.dart';
import 'package:animal_app/matchPage.dart';
import 'package:animal_app/recordPage.dart';
import 'package:animal_app/mapPage.dart';
import 'package:animal_app/linkPage.dart';

class BottomAPPBar extends StatefulWidget {
  int i = 0;

  BottomAPPBar(this.i, {Key? key}) : super(key: key);

  @override
  State<BottomAPPBar> createState() => _BottomAPPBarState();
}

class _BottomAPPBarState extends State<BottomAPPBar> {
  //創建視圖數組
  final pages = [
    MatchPage(), //配對頁面
    RecordPage(), //紀錄頁面
    HomePage(), //首頁
    MapPage(), //地圖頁面
    LinkPage(), //連結頁面
    MatchFilterPage(), //配對-篩選頁面
    MatchFavPage(), //配對-我的最愛頁面
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
    return Scaffold(
      //添加索引，顯示對應界面
      body: pages[_pageNumber],

      //添加一個懸浮按鈕home
      floatingActionButton: Container(
        height: 100,
        width: 100,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              onClicked(2);
            }, //按鈕點擊事件
            tooltip: '回到首頁', //按鈕長按提示
            child: Icon(
              Icons.home_filled,
            ),
            foregroundColor: floating_action_button_color,
            backgroundColor: Colors.amber,
          ),
        ),
      ),

      //懸浮按鈕和底部工具欄進行融合
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //添加底部5個切換功能match,record,home,map,link
      bottomNavigationBar: SizedBox(
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
      ),
    );
  }
}
