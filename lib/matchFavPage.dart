import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //http串接API
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
    List datas = [];
    var response = await http.get(Uri.parse(host));
    if (response.body.isNotEmpty) {
      datas = jsonDecode(response.body); //用jsonDecode解壓之後拿到所有資料並加進List datas裡
    }
    // print(datas);
    return datas; // http 0.13 後不能直接輸入 string
  }

  //檢查資料庫裡的id是否還是存在的
  checkAnimalList() async{
    await db.getAnimalId(); //拿到db.animalList

    List deleteDatas = []; //準備要刪除的id資料
    for(int i=0; i<db.animalList.length; i++){
      List datas = await getAnimalData("https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&animal_id=${db.animalList[i].toString()}");
      if(datas.isEmpty){
        deleteDatas.add(db.animalList[i]);
      }
    }

    //資料庫移除id、db.animalList移除id
    for(int i=0; i<deleteDatas.length; i++){
      await db.deleteAnimalId(deleteDatas[i]);
      db.animalList.remove(deleteDatas[i]);
    }
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
            future: checkAnimalList(), //檢查資料庫裡的id是否還是存在的
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
                            List datas = snapshot.data;

                            //創建動物
                            var data = datas[0];
                            Animal animal = Animal(
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

                            //動物的Card
                            return
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: (){
                                    List<String> hostCompList = ["https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&animal_id=${animal.id}"];
                                    // Navigator.pushNamedAndRemoveUntil(context, '/matchPage', (route) => false, arguments: hostCompList); //配對-頁面切換(左上角沒有返回鍵)
                                    Navigator.pushNamed(context, '/matchPage', arguments: hostCompList); //配對-頁面切換(左上角有返回鍵)
                                  },
                                  child: Card(
                                    color: Colors.amberAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30.0)),
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
                                            '收容編號：${animal.subid}',
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
                                    )),
                                ),
                              );
                          } else if (snapshot.hasError) {
                            print('Error: ${snapshot.error}');
                            return Container(
                                child: Center(
                                    child: Text(
                                        'Error: ${snapshot.error}'))); //失敗回傳空資料
                          } else {
                            print('Awaiting result...');
                            return Container(
                                child: Center(child: Text('努力加載浪浪資料中...')));
                          }
                        });
                  });
            }),
      ),
    );
  }
}
