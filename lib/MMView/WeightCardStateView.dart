
// 體重紀錄
import '../MM/HYSizeFit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter/material.dart';

import '../MM/MM.dart' ;
import '../TTM/TTMItem.dart';
import '../TTM/TTMPieCondition.dart';

import 'package:fl_chart/fl_chart.dart';

import 'dart:math';

class WeightCardStateView extends StatefulWidget{

  WeightCardStateView( this.item , this.data );
  final List<TTMPieConditionItem> data ;
  final TTMItem item ;

  //const WeightCard({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _WeightCardStateView(this.item ,this.data);
  }
}


class _WeightCardStateView extends State<WeightCardStateView>
{

  _WeightCardStateView( this.item ,this.data );
  final List<TTMPieConditionItem> data ;
  final TTMItem item ;

  final TextEditingController _textController = TextEditingController();


  @override
  void initState()
  {
    _textController.text = item.todayWeight.toString() ;
    _initData();
  }

  // 初始資料
  bool _isLoading = false ;
  Future<void> _initData()async
  {
    _isLoading = true ;
    _dateSet = await item.getWeightMonthList();
    _isLoading = false ;
    setState((){}) ;
  }

  @override
  Widget build(BuildContext context) {
    Widget ret = Scaffold(
        resizeToAvoidBottomInset: false ,

        appBar: AppBar(
          centerTitle: true,
          title: const Text('體重狀態') ,
          /*
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),*/
        ),
        body: Center(
          child:
          MM.newColumn( [
            Text('請輸入本日體重', style: TextStyle(fontSize: 20,)),

            _selectPage(),

            //
            MM.newElevatedButton("送出", () { _push() ;}) ,

            //
            _initPie(),
            // 上一頁
     //       MM.newElevatedButton("上一頁", () { MM.pop(context);}) ,

          ] ),
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
      await item.pushConditionWeight( double.parse( _textController.text ) ) ;
      _initData();
      return "ok" ;
    }catch( e )
    {
      return e.toString();
    }
  }


  // 本日體重選擇
  Widget _selectPage()
  {
    Widget ret = FormBuilderTextField(
      name: 'weight',
      //   focusNode: _expenseFocusNode,
      onSubmitted: (String ?value) {
        //Do anything with value
        //_nextFocus(_dateFocusNode);
        TextInputAction.next;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        hintText: '請輸入體重',
        hintStyle: const TextStyle(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      controller: _textController,
      keyboardType: TextInputType.number,
      /*
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],*/
    );

    ret = Padding( child : ret ,
        padding: EdgeInsets.fromLTRB( 20 , 10, 20, 10 ) ) ;
    return ret ;
  }

  // 長條圖
  int _touchedIndex = 0 ;
  Widget _initPie() {
    // 載入中，不用線圖
    if( _isLoading )
      return  Column( children:[
        SizedBox( height : 20 ),
        Text( "載入中" ),
        CircularProgressIndicator()

      ] );
    //
    //  final String bottomTitles =
    Widget ret =  LineChart(
        LineChartData(
       //   minX: 310 ,
          lineBarsData: [
            _linesBarDatas(),
          ],
       //   minY: -1.5,
          minX: 0,
          maxX: 31,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: leftTitleWidgets,
                reservedSize: 56,

              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 1 ,
                showTitles: true ,
                getTitlesWidget: bottomTitleWidgets,
                reservedSize: 36,

              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: true,
            horizontalInterval: 1.5,
            verticalInterval: 5,
            checkToShowHorizontalLine: (value) {
              return value.toInt() == 0;
            },
            checkToShowVerticalLine: (value) {
              return value.toInt() == 0;
            },
          ),
          // 邊框
          borderData:  FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(color: Colors.black),
                top: BorderSide(color: Colors.transparent),
                bottom: BorderSide(color: Colors.black),
                right: BorderSide(color: Colors.transparent),
              ),
          ),
        ),

    );

    final double size = 80.piw ;
    return SizedBox( child:  ret , width: size , height : size ,);
  }


  //
  TTMPieConditionValue _dateSet = TTMPieConditionValue() ;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {

    if(( value % 5 ).toInt() != 1 )
      return SizedBox.shrink();

    try {
      const style = TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
        fontFamily: 'Digital',
        fontSize: 6,
      );
/*
      String text;
      int index = value.toInt();
      if(( index % 5 ) <= 0 )
        throw "" ;
      text = "$index" ; //_dateSet.toKeys()[index] ;
*/

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(meta.formattedValue, style: style),
      );
    } catch( e )
    {

    }
     return Container();

  }


  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontSize: 10 ,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(meta.formattedValue, style: style),
    );
  }

  LineChartBarData _linesBarDatas()
  {
    List<double> values = _dateSet.toDoubleValues();
    List<int> day = _dateSet.toDay();
    List<FlSpot> spots = [] ;
    int i ;
    for( i = 0 ; i < values.length ; ++i )
    {
      if(  values[i].toDouble() >0.2 )
        spots.add( FlSpot( i.toDouble(), values[i] ));
    }
  //  spots.add( FlSpot(30,  1 )  );

    return LineChartBarData(
      dashArray: [2, 4], // 虛線

      spots: spots ,
      barWidth: 1,
      isStrokeCapRound: true,
  //    color: ,
      dotData: FlDotData( // 點線
        getDotPainter: (
            FlSpot, double, LineChartBarData, int)
        {
          return FlDotCirclePainter(
              radius: 2 ,
          );
        },
        show: true ,
      ),
    );
  }

}