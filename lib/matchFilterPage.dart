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
  String host = "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&album_file=http";

  //選項
  static List<Filter> _area = [
    Filter(id: 1, name: "台北", value: 2),
    Filter(id: 2, name: "新北", value: 3),
  ];
  static List<Filter> _kind = [
    Filter(id: 1, name: "貓", value: "貓"),
    Filter(id: 2, name: "狗", value: "狗"),
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
    Filter(id: 2, name: "白色", value: "白色"),
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

  //教學
  // final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
  }

  //(待改)取消按鈕的功能
  void onClickedCancel(){

  }

  //(待改)確定按鈕的功能
  void onClickedSure(){
    String hostComp = host;
    if (_selectedArea.length!=0){
      hostComp += "&animal_area_pkid=" + _selectedArea[0].value.toString();
    }
    if (_selectedKind.length!=0){
      hostComp += "&animal_kind=" + _selectedKind[0].value;
    }
    if (_selectedSex.length!=0){
      hostComp += "&animal_sex=" + _selectedSex[0].value;
    }
    if (_selectedAge.length!=0){
      hostComp += "&animal_age=" + _selectedAge[0].value;
    }
    if (_selectedBodytype.length!=0){
      hostComp += "&animal_bodytype=" + _selectedBodytype[0].value;
    }
    if (_selectedColour.length!=0){
      hostComp += "&animal_colour=" + _selectedColour[0].value;
    }
    if (_selectedSterilization.length!=0){
      hostComp += "&animal_sterilization=" + _selectedSterilization[0].value;
    }
    if (_selectedBacterin.length!=0){
      hostComp += "&animal_bacterin=" + _selectedBacterin[0].value;
    }
    Navigator.pushNamedAndRemoveUntil(context, '/matchPage', (route) => false, arguments: hostComp);
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
              //(待改)排序

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

              //(待改)確定和取消的按鈕
              Container(
                width: 432,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 取消按鈕
                    ElevatedButton(
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
                        child: Text('取消', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Inter",
                            fontStyle: FontStyle.normal,
                            fontSize: 15)),
                        onPressed: () {

                        }
                    ),

                    // 確定按鈕
                    ElevatedButton(
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
                        child: Text('確定', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Inter",
                            fontStyle: FontStyle.normal,
                            fontSize: 15)),
                        onPressed: () {
                          onClickedSure();
                        }
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}