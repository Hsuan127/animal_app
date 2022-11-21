import 'package:flutter/material.dart';
import 'package:animal_app/match_page_item/dataFromAnimalAPI.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';

class MatchPage extends StatefulWidget {
  String title = '配對';
  List<String> host = ["https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&album_file=http"];

  MatchPage({Key? key}) : super(key: key);

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    List<String>? hostCompList = ModalRoute.of(context)?.settings.arguments==null?null:ModalRoute.of(context)!.settings.arguments as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          //篩選
          IconButton(
            onPressed: () => {
              // Navigator.pushNamedAndRemoveUntil(context, '/matchPage/matchFilterPage', (route) => false) //篩選-頁面切換(左上角沒有返回鍵)
              Navigator.pushNamed(context, '/matchPage/matchFilterPage') //篩選-頁面切換(左上角有返回鍵)
            },
            icon: Icon(Icons.search, color: Colors.white),
          ),
          //我的最愛
          IconButton(
            onPressed: () => {
              // Navigator.pushNamedAndRemoveUntil(context, '/matchPage/matchFavPage', (route) => false) //我的最愛-頁面切換(左上角沒有返回鍵)
              Navigator.pushNamed(context, '/matchPage/matchFavPage') //我的最愛-頁面切換(左上角有返回鍵)
            },
            icon: Icon(Icons.favorite, color: Colors.redAccent),
          ),
        ],
      ),

      //設定
      drawer: Drawer(
        width: MediaQueryData.fromWindow(window).size.width / 2,
        child: ListView(
          children: <Widget>[
            //設定用戶資料
            UserAccountsDrawerHeader(
              //用戶名稱
              accountName: Text(
                "使用者",
              ),
              // 設定Email
              accountEmail: Text(
                FirebaseAuth.instance.currentUser?.email as String,
              ),
              //設定大頭照
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/iPet_logo.png"),
              ),
            ),
            //選單
            //推播通知開關
            ListTile(
              leading: CircleAvatar(child: Icon(Icons.notifications)),
              title: Text('推播通知開關'),
              onTap: () {
                // _onItemClick(0);
                Navigator.pushNamed(context, '/matchPage/matchFilterPage'); //篩選-頁面切換(左上角有返回鍵)
              },
            ),
            //使用手冊
            /*ListTile(
              leading: CircleAvatar(child: Icon(Icons.menu_book)),
              title: Text('使用手冊'),
              onTap: () {
                // _onItemClick(1);
              },
            ),*/
            //修改密碼
            ListTile(
              leading: new CircleAvatar(child: Icon(Icons.password)),
              title: Text('修改密碼'),
              onTap: () {
                // _onItemClick(2);
              },
            ),
            //登出
            ListTile(
              leading: CircleAvatar(child: Icon(Icons.logout)),
              title: Text('登出'),
              onTap: () {
                // _onItemClick(0);
              },
            ),
          ],
        ),
      ),

      drawerEnableOpenDragGesture: false,

      body: DataFromAnimalAPI(hostCompList ?? widget.host),

      //篩選條件按鈕
      /*floatingActionButton: Container(
        width: 50,
        height: 50,
        child: FittedBox(
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () => {
              // Navigator.pushNamedAndRemoveUntil(context, '/matchPage/matchFilterPage', (route) => false) //篩選-頁面切換(左上角沒有返回鍵)
              Navigator.pushNamed(context, '/matchPage/matchFilterPage') //篩選-頁面切換(左上角有返回鍵)
            }, //按鈕點擊事件
            tooltip: 'Search', //按鈕長按提示
            child: Icon(
              Icons.search,
              size: 30,
            ),
            foregroundColor: Colors.white,
            backgroundColor: Colors.amber,
          ),
        ),
      ),*/

    );
  }
}
