import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Match API',
      home: DataFromAPI(),
    );
  }
}

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
  final String host = 'https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&\$top=5';

  getAnimalData() {
    return http.get(Uri.parse(host)); // http 0.13 後不能直接輸入 string
  }

  List<Animal> animals = [];

  @override
  Widget build(BuildContext context) {
    // 改為 Scaffold 輸出
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Data'),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getAnimalData(), // 執行 http
            builder: (context, AsyncSnapshot snapshot) {
              // snapshot 抓資料，若有資料則:
              if (snapshot.hasData) {
                // jsonDecode 解壓
                List datas = jsonDecode(snapshot.data.body);
                print(datas);

                return ListView.builder(
                    itemCount: datas.length,
                    itemBuilder: (context, idx) {
                      var data = datas[idx];

                      Animal animal = new Animal(data['animal_id'].toString(), data['album_file'], data['animal_Variety']);
                      animals.add(animal);

                      return ListTile(
                          title: Text(animal.id.toString()),
                          subtitle: animal.animal_image(animal.album),
                          trailing: Text(animal.variety));
                    });
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
      ),
    );
  }
}

class Animal {
  final String id, album, variety;

  Animal(this.id, this.album, this.variety);

  animal_image(String album) {
    if (album != '') {
      return Image.network(album);
    } else {
      return null;
    }
  }
}