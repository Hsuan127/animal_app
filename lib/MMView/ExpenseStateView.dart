
// 花費明細
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter/material.dart' ;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../MM/MM.dart' ;
import '../MM/MMColor.dart';
import '../MM/MMWidget.dart';
import '../TTM/TTMItem.dart';
import '../TTM/TTMPieCondition.dart';

import 'package:fl_chart/fl_chart.dart';

import '../MM/HYSizeFit.dart';
import '../TTM/TTMSpendRecords.dart';


class SpendRecordSource extends DataGridSource
{
  List<DataGridRow> _vaccineData = [];
  final List<TTMSpendRecords> _monthSpends  ;

  void _buildDataRow() {
    _vaccineData = _monthSpends
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: '日期', value: e.getDate()),
      DataGridCell<String>(columnName: '花費', value: e.category),
      DataGridCell<int>(columnName: '金額', value: e.spend ),
    ]))
        .toList();
  }

  SpendRecordSource(this._monthSpends) {
    _buildDataRow();
  }




  @override
  List<DataGridRow> get rows => _vaccineData;

  @override
  DataGridRowAdapter buildRow(
      DataGridRow row,
      )
  {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          Widget ret =  Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),

          );

          //
          return ret ;
        }).toList());
  }
}

class ExpenseStateView extends StatefulWidget{

  ExpenseStateView( this.item );
  final TTMItem item ;

  //const WeightCard({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _ExpenseStateView(this.item );
  }
}


class _ExpenseStateView extends State<ExpenseStateView>
{

  _ExpenseStateView( this.item  );
  final TTMItem item ;


  @override
  Widget build(BuildContext context)
  {

    // 初始資料
    _initSpends();
    //
    Widget ret = MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  const Text('花費列表') ,

            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
        ),
        body:
        Padding(
          padding: EdgeInsets.only( top: 10, bottom: 50 ),
          child :  MM.newColumn( [
            _appBarTitle(),
            Row(
                mainAxisAlignment : MainAxisAlignment.center ,
                crossAxisAlignment : CrossAxisAlignment.end ,
        //        alignment: AlignmentDirectional.bottomEnd,
                children : [
              _initPie(),
                  _initPieText(),
            //   Text("2"),

            ]),
            _initMonthText(),
            /*
            MMWidget.newRow( [
              Expanded(child: _initPie() , flex: 2 , ),
              Expanded(child: _initPieColor() , flex: 1 , ),
            ] , MainAxisAlignment.center),

             */
            // 上一頁
            //     MM.newElevatedButton("上一頁", () { MM.pop(context);}) ,

            _buildDataGrid(),
          ] ),
        ),),


    );

    return ret;
  }

  //
  // 取得資料
  DateTime _dateTime = DateTime.now();

  @override
  void initState()
  {
    super.initState();
    _initData();
  }

  //
  // 標題
  Widget _appBarTitle()
  {
    setState((){});
    String str = "${_dateTime.year}年${_dateTime.month}月" ;
    return  MMWidget.newRowSA([
    MMWidget.newIconButton( Icons.keyboard_arrow_left_rounded , () =>
        setState((){
          _dateTime = new DateTime( _dateTime.year , _dateTime.month - 1 , _dateTime.day );
        })),
  Text( str ),
  MMWidget.newIconButton( Icons.keyboard_arrow_right_rounded , () =>
  setState((){
  _dateTime = new DateTime( _dateTime.year , _dateTime.month + 1 , _dateTime.day );

  }) )]
    );
  }
  //
  // 初始資料
  bool _isLoading = false ;
  Future<void> _initData()async
  {
    _isLoading = true ;
    _dateSet = await item.getSpendRecords();
    _isLoading = false ;
    setState((){}) ;
  }
  //

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
    // 沒有資料
    if( _spends.isEmpty )
      return Text( '本月沒有資料' , style: Theme.of(context).textTheme.headline4 ,) ;

    Widget ret = AspectRatio(
        aspectRatio: 0.1,
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
      )  ;
    final double size = 60.piw ;
    return SizedBox( child:  ret , width: size , height : size ,);

  }

  //
  // 本月花費文字
  Widget _initMonthText()
  {
    String str = "本月花費：$_monthTotal 平均一天：${(_monthTotal*100)~/30 / 100 }" ;
    Widget ret = Align( child : Text( str ) , alignment: Alignment.topCenter );
    ret = Padding( child: ret , padding: EdgeInsets.only(bottom: 10 ),);
    return ret ;
  }
  //
    //
  List<TTMSpendRecords> _dateSet = [] ;
  final List<Color> _dataColor = MMColor.expenseColor  ;


  // 初始資料
  int _monthTotal = 0 ;
  Map<String,int> _spends = {} ;
  List<TTMSpendRecords> _monthDateSet = [] ;
  void _initSpends()
  {
    _monthTotal = 0 ;
    _spends = {};
    _monthDateSet = [] ;
    for( final TTMSpendRecords spendRecords in _dateSet  )
      if( spendRecords.checkYYMM( _dateTime  ))
      {

        _monthTotal += spendRecords.spend ;
        _monthDateSet.add( spendRecords );
        if( _spends[spendRecords.category] == null )
          _spends[spendRecords.category] = 0 ;
        _spends[spendRecords.category] = _spends[spendRecords.category]! + spendRecords.spend ;
      }
  }
  //
  //
  List<int> _toValues()
  {
    final List<int> value = [] ;
    for( String key in _spends.keys ) {
      value.add( _spends[key]! ) ;
    }
    return value ;
  }

  List<String> _toKeys()
  {
    final List<String> keys = [] ;
    for( String key in _spends.keys ) {
      keys.add(key);
    }
    return keys ;
  }

  //
  //
  // text
  Widget _initPieText()
  {
    final double size = 12 ;
    final List<String> keys = _toKeys() ;
    final List<Widget> list = [] ;
    Widget c ;
    int i ;
    for( i = 0 ; i < keys.length ; ++i )
      {
        c = MM.newRow( [
          // 文字
        Container( color: _dataColor[i%_dataColor.length],
          width: size ,
          height: size ,
        ) ,
          Text( keys[i] , style: TextStyle(fontSize: 12) ),

        ] ) ;
        list.add( c );
      }

    return MM.newColumn( list , MainAxisAlignment.start , CrossAxisAlignment.start );

  }
  // 建資料
  List<PieChartSectionData> _initDataSet()
  {
    final List<int> value = _toValues() ;
      final List<String> keys = _toKeys() ;

    return List.generate(
        keys.length ,
            (i) {
          bool isTouched = ( i == _touchedIndex );
          Color color = _dataColor[i%_dataColor.length] ;
          return PieChartSectionData(
            color: color ,
            value: value[i].toDouble() ,
            title: "" ,//keys[i] ,
            radius: 30.piw ,
            titleStyle: const TextStyle(
                fontSize: 14,
            //    fontWeight: FontWeight.,
                color: Color(0xFF000000)),
            titlePositionPercentageOffset: 0.55,
            borderSide: isTouched
                ? BorderSide(color: color, width: 6)
                : BorderSide(color: color.withOpacity(0)),
          );
        });
  }

  //
  // 清單

  final DataGridController _dataGridController = DataGridController();
  late SpendRecordSource _vaccineDataSource ;
  Widget _buildDataGrid() {
    if (_isLoading)
      return MMWidget.newNullWidget();
    // 沒有資料
    if( _spends.isEmpty )
      return MMWidget.newNullWidget();


    _vaccineDataSource = SpendRecordSource(this._monthDateSet);
    return Expanded(child:
    SfDataGrid(
      //onCellTap : _onCellTap ,
      columnWidthMode: ColumnWidthMode.fill,
      selectionMode: SelectionMode.single,
      controller: _dataGridController,
      //    rowHeight: RowHeightDetails,
      source: _vaccineDataSource,
      columns: <GridColumn>[
        GridColumn(
            width: 30.piw,
            columnName: '日期',
            label: Container(
              //    padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  '日期',
                ))),
        GridColumn(
            columnName: '花費',
            label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text('花費'))
        ),
        GridColumn(
            columnName: '金額',
            label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text('金額'))
        ),
      ],)
    );
  }

}
