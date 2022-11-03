import 'package:flutter/material.dart';
import 'package:animal_app/match_page_item/dataFromAnimalAPI.dart';

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
          //搜尋
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
          //設定
          /*IconButton(
            onPressed: () => {

            },
            icon: Icon(Icons.settings, color: Colors.white),
          ),*/
        ],
      ),

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
