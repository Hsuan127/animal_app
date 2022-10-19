import 'package:flutter/material.dart';
import 'package:animal_app/match_page_item/dataFromAnimalAPI.dart';
import 'package:animal_app/matchFilterPage.dart';
import 'package:animal_app/matchFavPage.dart';

class MatchPage extends StatefulWidget {
  String host = "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&album_file=http";

  //TEST
  String title = '配對';

  MatchPage({Key? key}) : super(key: key);

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.pushNamedAndRemoveUntil(context, '/matchFavPage', (route) => false)
            },
            icon: Icon(Icons.archive),
          )
        ],
      ),

      body: DataFromAnimalAPI(widget.host),

      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () => {
              Navigator.pushNamedAndRemoveUntil(context, '/matchFilterPage', (route) => false)
            }, //按鈕點擊事件
            tooltip: 'Search', //按鈕長按提示
            child: Icon(
              Icons.search,
              size: 30.0,
            ),
            foregroundColor: Colors.white,
            backgroundColor: Colors.amber,
          ),
        ),
      ),
    );
  }
}
