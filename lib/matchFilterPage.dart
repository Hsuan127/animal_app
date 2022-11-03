import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart'; //篩選器
import 'dart:ui';

class MatchFilterPage extends StatefulWidget {
  MatchFilterPage({Key? key}) : super(key: key);

  @override
  State<MatchFilterPage> createState() => _MatchFilterPageState();
}

class _MatchFilterPageState extends State<MatchFilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('篩選條件'),
        centerTitle: true,
      ),

      body: MatchFilterBody(),
    );
  }
}

//篩選功能的Filter
class Filter {
  final int id;
  final String name;
  final value;

  Filter({
    required this.id,
    required this.name,
    required this.value
  });
}

//篩選功能的Body組成
class MatchFilterBody extends StatefulWidget {
  const MatchFilterBody({Key? key}) : super(key: key);

  @override
  State<MatchFilterBody> createState() => _MatchFilterBodyState();
}

class _MatchFilterBodyState extends State<MatchFilterBody> {
  final String host = "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&album_file=http";

  //選項
  static List<Filter> _area = [
    Filter(id: 1, name: "台北", value: 2),
    Filter(id: 2, name: "新北", value: 3),
    Filter(id: 3, name: "基隆", value: 4),
    Filter(id: 4, name: "宜蘭", value: 5),
    Filter(id: 5, name: "桃園", value: 6),
    Filter(id: 6, name: "新竹縣", value: 7),
    Filter(id: 7, name: "新竹市", value: 8),
    Filter(id: 8, name: "苗栗", value: 9),
    Filter(id: 9, name: "台中", value: 10),
    Filter(id: 10, name: "彰化", value: 11),
    Filter(id: 11, name: "南投", value: 12),
    Filter(id: 12, name: "雲林", value: 13),
    Filter(id: 13, name: "嘉義縣", value: 14),
    Filter(id: 14, name: "嘉義市", value: 15),
    Filter(id: 15, name: "台南", value: 16),
    Filter(id: 16, name: "高雄", value: 17),
    Filter(id: 17, name: "屏東", value: 18),
    Filter(id: 18, name: "花蓮", value: 19),
    Filter(id: 19, name: "台東", value: 20),
    Filter(id: 20, name: "澎湖", value: 21),
    Filter(id: 21, name: "金門", value: 22),
    Filter(id: 22, name: "連江", value: 23),
  ];
  static List<Filter> _kind = [
    Filter(id: 1, name: "貓貓", value: "貓"),
    Filter(id: 2, name: "狗狗", value: "狗"),
  ];
  static List<Filter> _sex = [
    Filter(id: 1, name: "公", value: "M"),
    Filter(id: 2, name: "母", value: "F"),
  ];
  static List<Filter> _age = [
    Filter(id: 1, name: "幼年", value: "CHILD"),
    Filter(id: 2, name: "成年", value: "ADULT"),
  ];
  static List<Filter> _bodytype = [
    Filter(id: 1, name: "小型", value: "SMALL"),
    Filter(id: 2, name: "中型", value: "MEDIUM"),
    Filter(id: 3, name: "大型", value: "BIG"),
  ];
  static List<Filter> _colour = [
    Filter(id: 1, name: "黑色", value: "黑色"),
    Filter(id: 2, name: "灰色", value: "灰色"),
    Filter(id: 3, name: "白色", value: "白色"),
    Filter(id: 4, name: "黃色", value: "黃色"),
    Filter(id: 5, name: "棕色", value: "棕色"),
    Filter(id: 6, name: "咖啡", value: "咖啡"),
    Filter(id: 7, name: "米色", value: "米色"),
    Filter(id: 8, name: "虎斑", value: "虎斑"),
    Filter(id: 9, name: "三花", value: "三花"),
    Filter(id: 10, name: "花色", value: "花色"),
    Filter(id: 11, name: "玳瑁色", value: "玳瑁色"),
  ];
  static List<Filter> _sterilization = [
    Filter(id: 1, name: "已絕育", value: "T"),
    Filter(id: 2, name: "未絕育", value: "F"),
  ];
  static List<Filter> _bacterin = [
    Filter(id: 1, name: "已施打", value: "T"),
    Filter(id: 2, name: "未施打", value: "F"),
  ];

  //選項變成items
  final items_sort =
  _area.map((sort) => MultiSelectItem<Filter>(sort, sort.name)).toList();
  final items_area =
  _area.map((area) => MultiSelectItem<Filter>(area, area.name)).toList();
  final items_kind =
  _kind.map((kind) => MultiSelectItem<Filter>(kind, kind.name)).toList();
  final items_sex =
  _sex.map((sex) => MultiSelectItem<Filter>(sex, sex.name)).toList();
  final items_age =
  _age.map((age) => MultiSelectItem<Filter>(age, age.name)).toList();
  final items_bodytype =
  _bodytype.map((bodytype) => MultiSelectItem<Filter>(bodytype, bodytype.name)).toList();
  final items_colour =
  _colour.map((colour) => MultiSelectItem<Filter>(colour, colour.name)).toList();
  final items_sterilization =
  _sterilization.map((sterilization) => MultiSelectItem<Filter>(sterilization, sterilization.name)).toList();
  final items_bacterin =
  _bacterin.map((bacterin) => MultiSelectItem<Filter>(bacterin, bacterin.name)).toList();

  //勾選之後存進的List
  List<Filter> _selectedArea = [];
  List<Filter> _selectedKind = [];
  List<Filter> _selectedSex = [];
  List<Filter> _selectedAge = [];
  List<Filter> _selectedBodytype = [];
  List<Filter> _selectedColour = [];
  List<Filter> _selectedSterilization = [];
  List<Filter> _selectedBacterin = [];

  //排序日期
  // int dateSort = 1;

  //教學
  // final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
  }

  //返回的按鈕
  /*void onClickedCancel(){
    List<String> hostCompList = [host];
    Navigator.pushNamedAndRemoveUntil(context, '/matchPage', (route) => false, arguments: hostCompList);
    Navigator.pop(context);
  }*/

  //確定的按鈕
  void onClickedSearch(){
    String hostComp = host;
    List<String> hostCompList = [];

    //日期排序方式
    /*if(dateSort==1){
      hostComp += "&animal_createtime=" + "";
    }
    else if(dateSort==2){
      hostComp += "&cDate=" + "";
    }*/

    //單字不會重複的篩選項目
    //animal_kind
    if (_selectedKind.length!=0){
      if(_selectedKind.length==1){
        hostComp += "&animal_kind=" + _selectedKind[0].value;
      }
      else{
        hostComp += "&animal_kind=[";
        for(int kind = 0; kind < _selectedKind.length; kind++){
          hostComp += _selectedKind[kind].value + ",";
        }
        hostComp += "]";
      }
    }
    //animal_sex
    if (_selectedSex.length!=0){
      if(_selectedSex.length==1){
        hostComp += "&animal_sex=" + _selectedSex[0].value;
      }
      else{
        hostComp += "&animal_sex=[";
        for(int sex = 0; sex < _selectedSex.length; sex++){
          hostComp += _selectedSex[sex].value + ",";
        }
        hostComp += "]";
      }
    }
    //animal_sterilization
    if (_selectedSterilization.length!=0){
      if(_selectedSterilization.length==1){
        hostComp += "&animal_sterilization=" + _selectedSterilization[0].value;
      }
      else{
        hostComp += "&animal_sterilization=[";
        for(int sterilization = 0; sterilization < _selectedSterilization.length; sterilization++){
          hostComp += _selectedSterilization[sterilization].value + ",";
        }
        hostComp += "]";
      }
    }
    //animal_bacterin
    if (_selectedBacterin.length!=0){
      if(_selectedBacterin.length==1){
        hostComp += "&animal_bacterin=" + _selectedBacterin[0].value;
      }
      else{
        hostComp += "&animal_bacterin=[";
        for(int bacterin = 0; bacterin < _selectedBacterin.length; bacterin++){
          hostComp += _selectedBacterin[bacterin].value + ",";
        }
        hostComp += "]";
      }
    }
    //單字會重複的篩選項目
    //animal_area_pkid
    if (_selectedArea.length!=0){
      for(int area = 0; area < _selectedArea.length; area++){
        String hostCompC = hostComp + "&animal_area_pkid=" + _selectedArea[area].value.toString();
        hostCompList.add(hostCompC);
      }
    }
    //animal_age
    if (_selectedAge.length!=0){
      if(hostCompList.isNotEmpty){
        int hostCompListOriginalLength = hostCompList.length;
        for(int h = 0; h < hostCompListOriginalLength; h++){
          for(int age = 0; age < _selectedAge.length; age++){
            String hostCompC = hostCompList[h];
            hostCompC += "&animal_age=" + _selectedAge[age].value; //hostCompList[h] -> hostComp
            hostCompList.add(hostCompC);
          }
        }
        hostCompList.removeRange(0, hostCompListOriginalLength);
      }
      else{
        for(int age = 0; age < _selectedAge.length; age++){
          String hostCompC = hostComp + "&animal_age=" + _selectedAge[age].value;
          hostCompList.add(hostCompC);
        }
      }
    }
    //animal_bodytype
    if (_selectedBodytype.length!=0){
      if(hostCompList.isNotEmpty){
        int hostCompListOriginalLength = hostCompList.length;
        for(int h = 0; h < hostCompListOriginalLength; h++){
          for(int bodytype = 0; bodytype < _selectedBodytype.length; bodytype++){
            String hostCompC = hostCompList[h];
            hostCompC += "&animal_bodytype=" + _selectedBodytype[bodytype].value; //hostCompList[h] -> hostComp
            hostCompList.add(hostCompC);
          }
        }
        hostCompList.removeRange(0, hostCompListOriginalLength);
      }
      else{
        for(int bodytype = 0; bodytype < _selectedBodytype.length; bodytype++){
          String hostCompC = hostComp + "&animal_bodytype=" + _selectedBodytype[bodytype].value;
          hostCompList.add(hostCompC);
        }
      }
    }
    //animal_colour
    if (_selectedColour.length!=0){
      if(hostCompList.isNotEmpty){
        int hostCompListOriginalLength = hostCompList.length;
        for(int h = 0; h < hostCompListOriginalLength; h++){
          for(int colour = 0; colour < _selectedColour.length; colour++){
            String hostCompC = hostCompList[h];
            hostCompC += "&animal_colour=" + _selectedColour[colour].value; //hostCompList[h] -> hostComp
            hostCompList.add(hostCompC);
          }
        }
        hostCompList.removeRange(0, hostCompListOriginalLength);
      }
      else{
        for(int colour = 0; colour < _selectedColour.length; colour++){
          String hostCompC = hostComp + "&animal_colour=" + _selectedColour[colour].value;
          hostCompList.add(hostCompC);
        }
      }
    }
    //沒有選到單字重複的篩選項目
    if(hostCompList.isEmpty){
      hostCompList.add(hostComp);
    }
    //傳送篩選條件資料
    Navigator.pushNamedAndRemoveUntil(context, '/matchPage', (route) => false, arguments: hostCompList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(40),
          child: Column(
            children: <Widget>[
              //日期排序方式
              /*Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      //排序
                      Text(
                        "排序方式",
                        style: TextStyle(

                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //依最新日期
                            Text("依最新日期"),
                            Radio(
                              value: 1, //按鈕的值
                              onChanged: (value){
                                setState(() {
                                  dateSort = value as int;
                                  print("依最新日期");
                                });
                              },
                              groupValue: dateSort, //按鈕組的值
                            ),
                            //依更新日期
                            Text("依更新日期"),
                            Radio(
                              value:2, //按鈕的值
                              onChanged: (value){
                                setState(() {
                                  dateSort = value as int;
                                  print("依更新日期");
                                });
                              },
                              groupValue: dateSort, //按鈕組的值
                            ),
                          ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 25),*/

              //地區
              Container(
                child: SingleChildScrollView(
                  child: MultiSelectDialogField(
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    initialValue: _selectedArea,
                    items: items_area,
                    title: Text(
                      "地區",
                      style: TextStyle(
                        color: Colors.orange[800],
                      ),
                    ),
                    dialogHeight: 300,
                    backgroundColor: Colors.amber[100],
                    checkColor: Colors.white,
                    selectedColor: Colors.orange,
                    unselectedColor: Colors.grey,
                    confirmText: Text(
                      "確認",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    cancelText: Text(
                      "取消",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.pets,
                      color: Colors.orange,
                    ),
                    buttonText: Text(
                      "地區",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      _selectedArea = results as List<Filter>;
                    },
                  ),
                ),
              ),

              SizedBox(height: 25),

              //動物種類
              Container(
                child: SingleChildScrollView(
                  child: MultiSelectDialogField(
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    initialValue: _selectedKind,
                    items: items_kind,
                    title: Text(
                      "動物種類",
                      style: TextStyle(
                        color: Colors.orange[800],
                      ),
                    ),
                    dialogHeight: 100,
                    backgroundColor: Colors.amber[100],
                    checkColor: Colors.white,
                    selectedColor: Colors.orange,
                    unselectedColor: Colors.grey,
                    confirmText: Text(
                      "確認",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    cancelText: Text(
                      "取消",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.pets,
                      color: Colors.orange,
                    ),
                    buttonText: Text(
                      "動物種類",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      _selectedKind = results as List<Filter>;
                    },
                  ),
                ),
              ),

              SizedBox(height: 25),

              //性別
              Container(
                child: SingleChildScrollView(
                  child: MultiSelectDialogField(
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    initialValue: _selectedSex,
                    items: items_sex,
                    title: Text(
                      "性別",
                      style: TextStyle(
                        color: Colors.orange[800],
                      ),
                    ),
                    dialogHeight: 100,
                    backgroundColor: Colors.amber[100],
                    checkColor: Colors.white,
                    selectedColor: Colors.orange,
                    unselectedColor: Colors.grey,
                    confirmText: Text(
                      "確認",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    cancelText: Text(
                      "取消",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.pets,
                      color: Colors.orange,
                    ),
                    buttonText: Text(
                      "性別",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      _selectedSex = results as List<Filter>;
                    },
                  ),
                ),
              ),

              SizedBox(height: 25),

              //年紀
              Container(
                child: SingleChildScrollView(
                  child: MultiSelectDialogField(
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    initialValue: _selectedAge,
                    items: items_age,
                    title: Text(
                      "年紀",
                      style: TextStyle(
                        color: Colors.orange[800],
                      ),
                    ),
                    dialogHeight: 100,
                    backgroundColor: Colors.amber[100],
                    checkColor: Colors.white,
                    selectedColor: Colors.orange,
                    unselectedColor: Colors.grey,
                    confirmText: Text(
                      "確認",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    cancelText: Text(
                      "取消",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.pets,
                      color: Colors.orange,
                    ),
                    buttonText: Text(
                      "年紀",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      _selectedAge = results as List<Filter>;
                    },
                  ),
                ),
              ),

              SizedBox(height: 25),

              //體型
              Container(
                child: SingleChildScrollView(
                  child: MultiSelectDialogField(
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    initialValue: _selectedBodytype,
                    items: items_bodytype,
                    title: Text(
                      "體型",
                      style: TextStyle(
                        color: Colors.orange[800],
                      ),
                    ),
                    dialogHeight: 150,
                    backgroundColor: Colors.amber[100],
                    checkColor: Colors.white,
                    selectedColor: Colors.orange,
                    unselectedColor: Colors.grey,
                    confirmText: Text(
                      "確認",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    cancelText: Text(
                      "取消",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.pets,
                      color: Colors.orange,
                    ),
                    buttonText: Text(
                      "體型",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      _selectedBodytype = results as List<Filter>;
                    },
                  ),
                ),
              ),

              SizedBox(height: 25),

              //毛色
              Container(
                child: SingleChildScrollView(
                  child: MultiSelectDialogField(
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    initialValue: _selectedColour,
                    items: items_colour,
                    title: Text(
                      "毛色",
                      style: TextStyle(
                        color: Colors.orange[800],
                      ),
                    ),
                    dialogHeight: 300,
                    backgroundColor: Colors.amber[100],
                    checkColor: Colors.white,
                    selectedColor: Colors.orange,
                    unselectedColor: Colors.grey,
                    confirmText: Text(
                      "確認",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    cancelText: Text(
                      "取消",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.pets,
                      color: Colors.orange,
                    ),
                    buttonText: Text(
                      "毛色",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      _selectedColour = results as List<Filter>;
                    },
                  ),
                ),
              ),

              SizedBox(height: 25),

              //絕育
              Container(
                child: SingleChildScrollView(
                  child: MultiSelectDialogField(
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    initialValue: _selectedSterilization,
                    items: items_sterilization,
                    title: Text(
                      "絕育",
                      style: TextStyle(
                        color: Colors.orange[800],
                      ),
                    ),
                    dialogHeight: 100,
                    backgroundColor: Colors.amber[100],
                    checkColor: Colors.white,
                    selectedColor: Colors.orange,
                    unselectedColor: Colors.grey,
                    confirmText: Text(
                      "確認",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    cancelText: Text(
                      "取消",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.pets,
                      color: Colors.orange,
                    ),
                    buttonText: Text(
                      "絕育",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      _selectedSterilization = results as List<Filter>;
                    },
                  ),
                ),
              ),

              SizedBox(height: 25),

              //狂犬病疫苗
              Container(
                child: SingleChildScrollView(
                  child: MultiSelectDialogField(
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    initialValue: _selectedBacterin,
                    items: items_bacterin,
                    title: Text(
                      "狂犬病疫苗",
                      style: TextStyle(
                        color: Colors.orange[800],
                      ),
                    ),
                    dialogHeight: 100,
                    backgroundColor: Colors.amber[100],
                    checkColor: Colors.white,
                    selectedColor: Colors.orange,
                    unselectedColor: Colors.grey,
                    confirmText: Text(
                      "確認",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    cancelText: Text(
                      "取消",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.pets,
                      color: Colors.orange,
                    ),
                    buttonText: Text(
                      "狂犬病疫苗",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      _selectedBacterin = results as List<Filter>;
                    },
                  ),
                ),
              ),

              SizedBox(height: 25),

              //搜尋和返回的按鈕
              Container(
                width: 432,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //返回按鈕
                    /*ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.amberAccent
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
                        child: Text('返回', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Inter",
                            fontStyle: FontStyle.normal,
                            fontSize: 15)),
                        onPressed: () {

                        }
                    ),*/

                    //搜尋按鈕
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.amberAccent
                          ),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Colors.transparent),
                              )
                          ),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.all(5)
                          ),
                        ),
                        child: Text('搜尋', style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22)),
                        onPressed: () {
                          onClickedSearch();
                        }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
