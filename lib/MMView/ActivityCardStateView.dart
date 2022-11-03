// 活動量紀錄
import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter/material.dart';

import '../MM/MM.dart';
import '../MM/MMColor.dart';
import '../TTM/TTMItem.dart';
import '../TTM/TTMPieCondition.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityCardStateView extends StatefulWidget {
  ActivityCardStateView(this.item, this.data);

  final List<TTMPieConditionItem> data;

  final TTMItem item;

  //const WeightCard({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _ActivityCardStateView(this.item, this.data);
  }
}

class _ActivityCardStateView extends State<ActivityCardStateView>
    with WidgetsBindingObserver
{
  _ActivityCardStateView(this.item, this.data);

  final List<TTMPieConditionItem> data;

  final TTMItem item;


  //
  //
  @override
  Widget build(BuildContext context) {
    Widget ret = Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text('活動量') ,
          /*
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop( true ),
          ),*/
        ),
        body: Center(
          child: MM.newColumn([
            Text('請輸入本日活動量',
                style: TextStyle(
                  fontSize: 20,
                )),
            // 本日活動量選擇
            _initSelect(),

            //
            MM.newElevatedButton("送出", () {
              _push();
            }),
            //
        //    Text("歷史資料"),
            //
            _initPie(),
            // 上一頁
     //       MM.newElevatedButton("上一頁", () { MM.pop(context);  }),
          ]),
        ),

    );

    return ret;
  }

  //
  // 送出
  Future<String> _push() async {
    try {
      await item.pushConditionActivity(_select);
      _initData();
      return "ok";
    } catch (e) {
      return e.toString();
    }
  }

  //
  int _select = 0;

  void _setSelect(int index) {
    setState(() => _select = index);
  }

  // 取得資料
  @override
  void initState() {
    super.initState();
    _select = item.todayActivityIndex ;
    _initData();
  }

  //
  // 初始資料
  Future<void> _initData() async {
    final data = await item.getActivityList();
    setState(() {
      _dateSet = data ;
    });
  }

  final _values = TTMItem.activityName ;
  //
  Widget _initSelect() {
    Color color = Colors.white;
    double fontSize = 20;
    Widget ret = MM.newRow([
      MM.newElevatedButton(
          _values[0], () => _setSelect(0), fontSize, (_select == 0) ? null : color),
      MM.newElevatedButton(
          _values[1], () => _setSelect(1), fontSize, (_select == 1) ? null : color),
      MM.newElevatedButton(
          _values[2], () => _setSelect(2), fontSize, (_select == 2) ? null : color),
    ], MainAxisAlignment.spaceAround);

    ret = Padding(child: ret, padding: EdgeInsets.all(20));
    return ret;
  }

  // 圖餅圖
  int _touchedIndex = 0;

  Widget _initPie() {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: _initCalender(), //Text( "test")
      ),
    );
  }

  //
  Map<String,int>_dateSet = {} ;

  final List<Color> _dataColor = MMColor.dataColor  ;


  //
  //
  // 初始日曆

  Widget _initCalender()
  {


    //
    //
    Widget ret = TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      daysOfWeekHeight: 48,
//      rowHeight: 52,
      locale: 'zh_TW',
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },

      calendarBuilders:  CalendarBuilders(
          outsideBuilder: ( context,  day , _ ) // 今天
          {
            return _buildCalendarDay( day.day.toString()
                , Colors.white
                , Colors.black54
                , Colors.transparent )
            ;
          },
        todayBuilder: ( context,  day , _ ) // 今天
        {
          return _buildCalendar( day );
        },

        defaultBuilder: ( context,  day , _ ) // 今天
        {
          return _buildCalendar( day );
        },
      ),

      //    holidays: _holidays ,
    );
    if (false)
      ret = SizedBox(
        child: ret,
        width: 200,
      );
    //  ret = Padding( child: ret , padding: EdgeInsets.only( left: 20 , right: 20 ),);
    ret = MM.newScroll(ret);
    return ret;
  }

  //
  String dateToStr( DateTime day )
  {
    return "${day.year}/${day.month}/${day.day}" ;
  }

  //
  Container _buildCalendar( DateTime day )
  {

    try {
      String dayStr = dateToStr( day );
      int value = _dateSet[dayStr] as int ;
      return _buildCalendarDay(day.day.toString()
          , _dataColor[value]
          , Colors.black
          , Colors.black54);
    }catch(_)
    {
      return _buildCalendarDay(day.day.toString()
          , Colors.white
          , Colors.black
          , Colors.white);

    }
  }
  //

  Container _buildCalendarDay(
    String day,
    Color backColor ,
    Color color,
      Color borderColor ,
  ) {

    return Container(
  //    color: backColor,
      width: 48,
      height: 48,
      decoration: new BoxDecoration(
        //背景
        color: backColor ,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        border: new Border.all(width: 1, color: borderColor ),
      ),
      //border: new Border.all(width: 1, color: Colors.red),
      child: Center(
        child: Text(day,
            style: TextStyle(fontSize: 12, color: color )),
      ),
    );
  }

  AnimatedContainer buildCalendarDayMarker(
    String text ,
    Color backColor,
  ) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: backColor,
      ),
      width: 52,
      height: 13,
      child: Center(
        child: Text(
          text,
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }
}

