import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatchFavPage extends StatefulWidget {
  const MatchFavPage({Key? key}) : super(key: key);

  @override
  State<MatchFavPage> createState() => _MatchFavPageState();
}

class _MatchFavPageState extends State<MatchFavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的最愛'),
        centerTitle: true,
      ),

      body: DataFromAPI(),

    );
  }
}

//動物的資訊
class Animal {
  // final String id, album, variety;
  final String album, variety, age, sex;

  // Animal(this.id, this.album, this.variety);
  Animal(this.album, this.variety, this.age, this.sex);

  animal_image(String album) {
    if (album != '') {
      return Image.network(album);
    } else {
      return null;
    }
  }
}

//串接動物API
class DataFromAPI extends StatefulWidget {
  const DataFromAPI({Key? key}) : super(key: key);

  @override
  State<DataFromAPI> createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  // 原例: 延遲 2 秒後傳入 String 'Data Loaded'
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );

  // 輸入資料網址 令 http 抓取資料
  final String host =
      'https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&\$top=1&album_file=http';

  getAnimalData() {
    return http.get(Uri.parse(host)); // http 0.13 後不能直接輸入 string
  }

  List<Animal> animals = [];

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
              // jsonDecode 解壓
              List datas = jsonDecode(snapshot.data.body);
              print(datas);

              Animal animal;

              for (int idx = 0; idx < datas.length; idx++) {
                var data = datas[idx];

                animal = new Animal(data['album_file'], data['animal_Variety'],
                    data['animal_age'], data['animal_sex']);
                animals.add(animal);
              }

              return Stack(
                children: [
                  Container(
                    width: 432,
                    height: 864,
                  ),
                  PositionedDirectional(
                    top: 159,
                    start: 68,
                    child: Stack(children: [
                      Container(
                        width: 432,
                        height: 864,
                      ),
                      // Rectangle 2
                      PositionedDirectional(
                        top: 0,
                        start: 0,
                        child: Container(
                          width: 295.651,
                          height: 382.672,
                          child: animals[0].animal_image(animals[0].album),
                        ),
                      ),
                      // Rectangle 3
                      PositionedDirectional(
                        top: 341.441,
                        start: 30.123,
                        child: Container(
                            width: 235.405,
                            height: 82.559,
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
                                color: Color(0xffffffff))),
                      ),
                      // 小明
                      PositionedDirectional(
                        top: 354.829,
                        start: 54.667,
                        child: Text(animals[0].variety,
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter",
                                fontStyle: FontStyle.normal,
                                fontSize: 20.1),
                            textAlign: TextAlign.left),
                      ),
                      // 3歲 男
                      PositionedDirectional(
                        top: 388.299,
                        start: 54.667,
                        child: Text(animals[0].age + ' ' + animals[0].sex,
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter",
                                fontStyle: FontStyle.normal,
                                fontSize: 15.9),
                            textAlign: TextAlign.left),
                      )
                    ]),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              return Container(); // 失敗回傳空資料
            } else {
              print('Awaiting result...');
              return Container();
            }
          },
        ),
      ),
      // ),
    );
  }
}