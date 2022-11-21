import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //http串接API
import 'package:drag_like/drag_like.dart'; //Drag左右滑功能
import 'dart:convert';
import 'dart:ui';
import 'package:animal_app/match_page_item/animal.dart';
import 'package:animal_app/match_page_item/drag.dart';
import 'package:animal_app/match_page_item/matchFavDB.dart';

//串接動物API
class DataFromAnimalAPI extends StatefulWidget {
  List<String> hostCompList; //用來存放所有需要介接API的網址
  DataFromAnimalAPI(this.hostCompList, {Key? key}) : super(key: key);

  @override
  State<DataFromAnimalAPI> createState() => _DataFromAnimalAPIState();
}

class _DataFromAnimalAPIState extends State<DataFromAnimalAPI> {
  //Drag左右滑功能
  DragController _dragController = DragController();

  //把動物資料放進animals
  List<Animal> animals = [];

  //把動物資料放進drag
  List<Animal> animals_drag = [];

  //串接動物API
  getAnimalData() async {
    List datas = [];
    for (int h = 0; h < widget.hostCompList.length; h++){
      var response = await http.get(Uri.parse(widget.hostCompList[h]));
      if (response.body.isNotEmpty) {
        datas.add(jsonDecode(response.body)); //用jsonDecode解壓之後拿到所有資料並加進List datas裡
      }
    }
    datas.toSet(); //去掉datas裡重複的資料
    // print(datas);
    return datas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: getAnimalData(), // 執行http
          builder: (context, AsyncSnapshot snapshot) {
            //用snapshot抓資料，若有資料則:
            if (snapshot.hasData) {
              List datas = snapshot.data;
              // print(datas);

              //把每一筆資料加進List<Animal> animals裡面
              Animal animal;
              for (int idx = 0; idx < datas[0].length; idx++) {
                var data = datas[0][idx];
                // print(data);
                animal = Animal(
                  data['animal_id'],
                  data['animal_subid'],
                  data['animal_area_pkid'],
                  data['animal_kind'],
                  data['animal_Variety'],
                  data['animal_sex'],
                  data['animal_bodytype'],
                  data['animal_colour'],
                  data['animal_age'],
                  data['animal_sterilization'],
                  data['animal_bacterin'],
                  data['animal_foundplace'],
                  data['animal_remark'],
                  data['shelter_name'],
                  data['album_file'],
                  data['cDate'],
                  data['shelter_address'],
                  data['shelter_tel'],
                );
                animals.add(animal);
              }

              //把List<Animal> animals裡面的每一筆資料加進List<Animal> animals_drag裡面
              animals_drag.addAll(animals);

              return Center(
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        //產生可以drag的畫面
                        Container(
                          padding: EdgeInsets.only(
                              left: MediaQueryData.fromWindow(window).padding.left,
                              right: MediaQueryData.fromWindow(window).padding.right,
                              top: 0,
                              bottom: 0
                          ),
                          child: DragLike(
                            dragController: _dragController,
                            duration: Duration(milliseconds: 520),
                            allowDrag: true,
                            child: animals_drag.length <= 0
                                ? Container(child: Center(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('暫無符合此篩選條件的浪浪！'),
                                    Text('請重新設定篩選條件哦～'),
                                  ],
                                )))
                                : Drag(animal: animals_drag[0]),
                            secondChild: animals_drag.length <= 1
                                ? Container()
                                : Drag(animal: animals_drag[1]),
                            screenWidth: MediaQueryData.fromWindow(window).size.width, //375
                            outValue: 0.8,
                            dragSpeed: 2000,
                            onChangeDragDistance: (distance) {
                              /// {distance: 0.17511112467447917, distanceProgress: 0.2918518744574653}
                              // print(distance.toString());
                            },
                            onOutComplete: (type) {
                              //left or right
                              print(type);

                              if (type == "right") {
                                //存動物id至資料庫
                                MatchFavDB().addAnimalId(animals_drag[0].id);

                                //底部提示訊息
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        width: MediaQueryData.fromWindow(window).size.width / 2,
                                        backgroundColor: Colors.white12,
                                        duration: Duration(seconds: 1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        behavior: SnackBarBehavior.floating,
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              '喜歡',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.amber[100],
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            ),
                                          ],
                                        )));
                              }
                            },
                            onScaleComplete: () {
                              animals_drag.remove(animals_drag[0]);
                              if (animals_drag.length == 0) {}
                              setState(() {});
                            },
                            onPointerUp: () {},
                            onCancel: () {
                              print('取消了');
                            },
                          ),
                        ),

                        //左右滑的按鈕
                        Positioned(
                            left: MediaQueryData.fromWindow(window).padding.left,
                            top: (MediaQueryData.fromWindow(window).size.height - 100) / 2.3,
                            child: Container(
                              width: MediaQueryData.fromWindow(window).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  //左滑按鈕
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(Color(0x7F808080)), //Colors.grey[100]
                                        elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                              color: Colors.transparent),
                                        )),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.all(0)),
                                      ),
                                      child: Icon(Icons.highlight_remove,
                                          color: Colors.white, size: 24.0),
                                      onPressed: () async {
                                        if (animals_drag.length > 0)
                                          _dragController.toLeft(
                                              completeTag: 'custom_left');
                                      }),

                                  //提示動物圖片可左右滑
                                  CircleAvatar(child: Icon(Icons.swipe, color: Colors.white), backgroundColor: Color(0x7F808080),),

                                  //右滑按鈕
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(Color(0x7Fff0000)), //Colors.pinkAccent
                                        elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                              color: Colors.transparent),
                                        )),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.all(0)),
                                      ),
                                      child: Icon(Icons.favorite,
                                          color: Colors.white, size: 24.0),
                                      onPressed: () async {
                                        if (animals_drag.length > 0) {
                                          _dragController.toRight(
                                              completeTag: 'custom_right');

                                          //存動物id至資料庫
                                          MatchFavDB()
                                              .addAnimalId(animals_drag[0].id);

                                          //底部提示訊息
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  width: MediaQueryData.fromWindow(window).size.width / 2, //250
                                                  backgroundColor:
                                                      Colors.white12,
                                                  duration:
                                                      Duration(seconds: 1),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50))),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      ),
                                                      Text(
                                                        '喜歡',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.amber[100],
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      ),
                                                    ],
                                                  )));
                                        }
                                      }),
                                ],
                              ),
                            ))

                      ],
                    )),
              );
            } else if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              return Container(
                  child: Center(
                      child: Text('Error: ${snapshot.error}'))); // 失敗回傳空資料
            } else {
              print('Awaiting result...');
              return Container(child: Center(child: Text('努力加載浪浪資料中...')));
            }
          },
        ),
      ),
    );
  }
}
