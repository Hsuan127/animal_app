import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //http
import 'dart:convert';
import 'package:animal_app/match_page_item/matchFavDB.dart';
import 'package:animal_app/match_page_item/animal.dart';

class MatchFavPage extends StatefulWidget {
  const MatchFavPage({Key? key}) : super(key: key);

  @override
  State<MatchFavPage> createState() => _MatchFavPageState();
}

class _MatchFavPageState extends State<MatchFavPage> {
  MatchFavDB db = MatchFavDB(); //matchFavDB

  //取消關注
  void btnClickEvent(int animalId) {
    //刪除資料庫裡特定的動物id
    db.deleteAnimalId(animalId);
  }

  //串接動物API
  getAnimalData(String host) async {
    var response = await http.get(Uri.parse(host));
    return response; // http 0.13 後不能直接輸入 string
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的最愛'),
        centerTitle: true,
      ),

      body: Container(
        color: Colors.white,
        child: FutureBuilder(
            future: db.getAnimalId(),
            builder: (context, AsyncSnapshot snapshot) {
              return ListView.builder(
                  itemCount: db.animalList.length,
                  itemBuilder: (context, index) {
                    //串接API抓動物資料
                    return FutureBuilder(
                        future: getAnimalData(
                            "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&animal_id=${db.animalList[index].toString()}"),
                        builder: (context, AsyncSnapshot snapshot) {
                          //用snapshot抓資料，若有資料則:
                          if (snapshot.hasData) {
                            //用jsonDecode解壓之後拿到所有資料並加進List datas裡
                            List datas = jsonDecode(snapshot.data.body);

                            //創建動物
                            var data = datas[0];
                            Animal animal = Animal(
                                data['animal_id'],
                                data['album_file'],
                                data['animal_Variety'],
                                data['animal_age'],
                                data['animal_sex'],
                                data['animal_colour'],
                                data['animal_bodytype'],
                                data['shelter_name'],
                                data['animal_kind']);

                            //動物的Card
                            return Card(
                                color: Colors.amberAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                clipBehavior: Clip.antiAlias, //抗鋸齒
                                elevation: 20, //陰影大小
                                child: Container(
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: ListTile(
                                      //該動物的圖片
                                      // leading: animal.animalImage(animal.album),
                                      leading: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: animal.animalImage(animal.album),
                                      ),

                                      //該動物的收容所
                                      title: Text(
                                        animal.shelterName,
                                      ),

                                      //該動物的id
                                      subtitle: Text(
                                        'ID : ${animal.id}',
                                      ),

                                      //關注or取消關注
                                      trailing: IconButton(
                                        color: Colors.red,
                                          onPressed: () {
                                            setState(() {
                                              btnClickEvent(animal.id);
                                            });
                                          },
                                          icon: Icon(Icons.favorite))),
                                ));
                          } else if (snapshot.hasError) {
                            print('Error: ${snapshot.error}');
                            return Container(
                                child: Center(
                                    child: Text(
                                        'Error: ${snapshot.error}'))); // 失敗回傳空資料
                          } else {
                            print('Awaiting result...');
                            return Container(
                                child: Center(child: Text('資料加載中請稍候...')));
                          }
                        });
                  });
            }),
      ),
    );
  }
}
