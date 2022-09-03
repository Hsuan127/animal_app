import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:drag_like/drag_like.dart'; //Drag左右滑功能
import 'dart:ui';

class MatchPage extends StatefulWidget {
  String host = "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&album_file=http";

  MatchPage({Key? key}) : super(key: key);

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("配對"),
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
      body: Center(child: DataFromAPI(widget.host)),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/matchFilterPage', (route) => false);
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

// 動物的資訊
class Animal {
  String album, variety, age, sex, colour, bodytype, shelterName, kind;

  Animal(this.album, this.variety, this.age, this.sex, this.colour, this.bodytype, this.shelterName, this.kind);

  //動物的圖片
  animalImage(String album) {
    if (album != '') {
      return Image.network(album);
    } else {
      return null;
    }
  }

  //轉換名稱(animal_sex)
  changeSexName(text) {
    //animal_sex
    switch (text) {
      case "M":
        sex = "公";
        break;
      case "F":
        sex = "母";
        break;
      case "N":
        sex = "";
        break;
    }
    return sex;
  }

  // 轉換名稱(animal_bodytype)
  changeBodytypeName(text) {
    switch(text) {
      case "SMALL":
        bodytype = "小型";
        break;
      case "MEDIUM":
        bodytype = "中型";
        break;
      case "BIG":
        bodytype = "大型";
        break;
    }
    return bodytype;
  }
}

// 串接動物API
class DataFromAPI extends StatefulWidget {
  String host;

  DataFromAPI(this.host, {Key? key}) : super(key: key);

  @override
  State<DataFromAPI> createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  // Drag左右滑功能
  DragController _dragController = DragController();

  // 把動物資料放進animals
  List<Animal> animals = [];

  // 把動物資料放進drag
  List<Animal> animals_drag = [];

  // 輸入資料網址 令 http 抓取資料
  // final String host = 'https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&\$top=1&album_file=http';
  //String host = 'https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&album_file=http';

  // 串接動物API
  getAnimalData() async{
    var response = await http.get(Uri.parse(widget.host));
    return response; // http 0.13 後不能直接輸入 string
  }

  @override
  Widget build(BuildContext context) {
    // 改為 Scaffold 輸出
    return Scaffold(
      body: Container(
        // child: Card(
        child: FutureBuilder(
          future: getAnimalData(), // 執行 http
          builder: (context, AsyncSnapshot snapshot) {
            // snapshot 抓資料，若有資料則:
            if (snapshot.hasData) {
              // jsonDecode解壓之後拿到所有資料並加進List datas裡
              List datas = jsonDecode(snapshot.data.body);
              // print(datas);

              // 把每一筆資料加進List<Animal> animals裡面
              Animal animal;
              for (int idx = 0; idx < datas.length; idx++) {
                var data = datas[idx];
                animal = new Animal(data['album_file'], data['animal_Variety'],
                    data['animal_age'], data['animal_sex'], data['animal_colour'], data['animal_bodytype'], data['shelter_name'], data['animal_kind']);
                animals.add(animal);
              }

              // 把List<Animal> animals裡面的每一筆資料加進List<Animal> animals_drag裡面
              animals_drag.addAll(animals);

              return Center(
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        // 產生可以drag的畫面
                        Container(
                          padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                          child: DragLike(
                            dragController: _dragController,
                            duration: Duration(milliseconds: 520),
                            allowDrag: true,
                            child: animals_drag.length <= 0
                                ? Text('加载中...')
                                :TestDrag(animal: animals_drag[0]),
                            secondChild: animals_drag.length <= 1
                                ? Container()
                                :TestDrag(animal: animals_drag[1]),
                            screenWidth: 375,
                            outValue: 0.8,
                            dragSpeed: 1000,
                            onChangeDragDistance: (distance) {
                              /// {distance: 0.17511112467447917, distanceProgress: 0.2918518744574653}
                              // print(distance.toString());
                            },
                            onOutComplete: (type) {
                              /// left or right
                              print(type);
                            },
                            onScaleComplete: () {
                              animals_drag.remove(animals_drag[0]);
                              if (animals_drag.length == 0) {
                              }
                              setState(() {});
                            },
                            onPointerUp: () {},
                            onCancel: (){
                              print('取消了');
                            },
                          ),
                        ),
                        // 左右滑的按鈕
                        Positioned(
                            left: 0,
                            bottom: MediaQueryData.fromWindow(window).padding.bottom + 40,
                            child: Container(
                              width: 432,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // 左滑按鈕
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Colors.blueAccent
                                        ),
                                        elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25),
                                              side: BorderSide(color: Colors.transparent),
                                            )
                                        ),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.all(15)
                                        ),
                                      ),
                                      child: Icon(Icons.highlight_remove, color: Colors.white, size: 24.0),
                                      onPressed: () async{
                                        if(animals_drag.length > 0) _dragController.toLeft(completeTag: 'custom_left');
                                      }
                                  ),

                                  // 右滑按鈕
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Colors.pinkAccent
                                        ),
                                        elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25),
                                              side: BorderSide(color: Colors.transparent),
                                            )
                                        ),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.all(15)
                                        ),
                                      ),
                                      child: Icon(Icons.favorite, color: Colors.white, size: 24.0),
                                      onPressed: () async{
                                        if(animals_drag.length > 0) _dragController.toRight(completeTag: 'custom_right');

                                        /////////////////////////
                                        // 存動物的id進資料庫?
                                        /////////////////////////

                                      }
                                  ),
                                ],
                              ),
                            )
                        )
                      ],
                    )),
              );
            } else if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              return Container(child: Center(child: Text('Error: ${snapshot.error}'))); // 失敗回傳空資料
            } else {
              print('Awaiting result...');
              return Container(child: Center(child: Text('資料加載中請稍候...')));
            }
          },
        ),
      ),
      // ),
    );
  }
}

//Drag左右滑功能
class TestDrag extends StatefulWidget {
  final Animal animal;
  const TestDrag({Key ? key, required this.animal}) : super(key: key);

  @override
  _TestDragState createState() => _TestDragState();
}

class _TestDragState extends State<TestDrag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.amber[200],
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 動物的image
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 432,
              height: 405,
              child: widget.animal.animalImage(widget.animal.album),
            ),
          ),
          // 下面的框框
          Positioned(
            left: 68,
            top: 405,
            child: Container(
                width: 296,
                height: 145,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(11)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x40000000),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    // color: Color(0xffffffff)
                    color: Colors.amber[200]
                )),
          ),
          // 動物的variety
          Positioned(
            left: 100,
            top: 410,
            child: Container(
              width: 100,
              height: 100,
              child: Text(widget.animal.variety,
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      fontStyle: FontStyle.normal,
                      fontSize: 20.1),
                  textAlign: TextAlign.left),
            ),
          ),
          // 動物的sex, color, bodtytype, kind, shelter_name
          Positioned(
            left: 100,
            top: 445,
            child: Container(
              width: 250,
              height: 100,
              child: Text(widget.animal.changeSexName(widget.animal.sex) + "\n" + widget.animal.colour + "\n" + widget.animal.changeBodytypeName(widget.animal.bodytype) + widget.animal.kind + "\n" + widget.animal.shelterName,
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.9),
                  textAlign: TextAlign.left),
            ),
          ),
        ],
      ),
    );
  }
}