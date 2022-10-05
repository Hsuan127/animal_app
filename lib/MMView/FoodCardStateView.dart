
// 體重紀錄
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../MM/HYSizeFit.dart';

import 'package:flutter/material.dart';

import '../MM/MM.dart' ;
import '../MM/MMColor.dart';
import '../TTM/TTMItem.dart';
import '../TTM/TTMPieCondition.dart';

import 'package:fl_chart/fl_chart.dart';


class FoodCardStateView extends StatefulWidget{

  FoodCardStateView( this.item , this.data );
  final List<TTMPieConditionItem> data ;
  final TTMItem item ;

  //const WeightCard({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _FoodCardStateView(this.item , this.data);
  }
}


class _FoodCardStateView extends State<FoodCardStateView>
{

  _FoodCardStateView( this.item , this.data );
  final List<TTMPieConditionItem> data ;
  final TTMItem item ;



  @override
  Widget build(BuildContext context) {
      Widget ret = MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Center( child:  const Text('飲食狀態') ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Center(
            child:
            MM.newColumn( [
              Text('請輸入本日飲食狀態', style: TextStyle(fontSize: 20,)),
              // 本日排便選擇
              _initSelect(),

              //
              MM.newElevatedButton("送出", () { _push() ;}) ,
              //
              _initPie(),
              // 上一頁
     //         MM.newElevatedButton("上一頁", () { MM.pop(context);}) ,

            ] ),
          ),
        ),

      );

      return ret;
    }

    //
    // 送出
    Future<String> _push() async
    {
      try
      {
        await item.pushConditionFood( _select ) ;
        _initData();
        return "ok" ;
      }catch( e )
      {
        return e.toString();
      }
    }


    //
  int _select = 0 ;
  void _setSelect( int index )
  {
    setState(() =>
        _select = index
    );
  }
  // 取得資料
  @override
  void initState()
  {
    super.initState();

    _select = item.todayFoodIndex ;
    _initData();
  }

  //
  // 初始資料
  bool _isLoading = false ;
  Future<void> _initData()async
  {
    _isLoading = true ;
    _dateSet = await item.getFoodMonthList();
    _isLoading = false ;
    setState((){}) ;
  }

  final _values = TTMItem.foodName ;
  //
  Widget _initSelect()
  {
    Color color = Colors.white ;
    double fontSize = 20 ;
        Widget ret = MM.newRow([
      MM.newElevatedButton(_values[0], () => _setSelect( 0 ) , fontSize , ( _select == 0 )? null : color ),
      MM.newElevatedButton(_values[1], () => _setSelect( 1 ), fontSize , ( _select == 1 )? null : color ),
      MM.newElevatedButton(_values[2], () => _setSelect( 2 ), fontSize , ( _select == 2 )? null : color ),
    ],MainAxisAlignment.spaceAround );

    ret = Padding( child : ret , padding: EdgeInsets.all( 20 )) ;
    return ret ;
  }
  // 圖餅圖
  int _touchedIndex = 0 ;
  Widget _initPie()
  {
    // 載入中，不用線圖
    if( _isLoading )
      return  Column( children:[
        SizedBox( height : 20 ),
        Text( "載入中" ),
        CircularProgressIndicator()

      ] );

    Widget ret = AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
            pieTouchData: PieTouchData(touchCallback:
                (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  _touchedIndex = -1;
                  return;
                }
                _touchedIndex = pieTouchResponse
                    .touchedSection!.touchedSectionIndex;
              });
            }),
            startDegreeOffset: 180,
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 1,
            centerSpaceRadius: 0,
            sections: _initDataSet()),
      ),
    );
    final double size = 80.piw ;
    return SizedBox( child:  ret , width: size , height : size ,);

  }

    //
  TTMPieConditionValue _dateSet = TTMPieConditionValue() ;
  final List<Color> _dataColor = MMColor.dataColor  ;


    // 建資料
  List<PieChartSectionData> _initDataSet()
  {

    final List<dynamic> value = _dateSet.toValues();
    final List<String> keys = _dateSet.toKeys();

    return List.generate(
        keys.length ,
            (i) {
          bool isTouched = ( i == _touchedIndex );
          Color color = _dataColor[i] ;
          return PieChartSectionData(
            color: color ,
            value: value[i].toDouble() ,
            title: keys[i] ,
            radius: 120,
            titleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff0c7f55)),
            titlePositionPercentageOffset: 0.55,
            borderSide: isTouched
                ? BorderSide(color: color, width: 6)
                : BorderSide(color: color.withOpacity(0)),
          );
        });
  }
}