import 'package:animal_app/MM/HYSizeFit.dart';
import 'package:animal_app/TTM/TTMDoctor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:animal_app/record_page_item/add_doctor.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../MM/MM.dart';
import '../MM/MMWidget.dart';
import '../TTM/TTMItem.dart';
import '../TTM/TTMUser.dart';
import 'edit_doctor.dart';


class DoctorDataSource extends DataGridSource {
  DoctorDataSource(this.doctorData) {
    _buildDataRow();
  }




  List<DataGridRow> _vaccineData = [];
  List<TTMDoctor> doctorData;

  void _buildDataRow() {
    _vaccineData = doctorData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: '日期', value: e.getDate()),
      DataGridCell<String>(columnName: '醫院', value: e.hospital),
      DataGridCell<String>(columnName: '問題', value: e.problem ),
    ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _vaccineData;

  @override
  DataGridRowAdapter buildRow(
      DataGridRow row,
      ) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          Widget ret =  Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),

          );

          // button

          //
          return ret ;
        }).toList());
  }
}

class DoctorPage extends StatefulWidget {


  DoctorPage( this.user , this.item );

  final TTMUser user ;
  final TTMItem item ;


  @override
  State<StatefulWidget> createState() {
    //createState方法會回傳一個state組件
    return _DoctorPageState( this.user , this.item  );
    //上述的組件就是這個
  }
}

class _DoctorPageState extends State<DoctorPage> {

  late DoctorDataSource _vaccineDataSource;
  List<TTMDoctor> _doctorData = [];
  List<String> docID = [];

  _DoctorPageState( this.user , this.item );

  final TTMUser user ;
  final TTMItem item ;


  void _navigateToAddDoctorScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddDoctor( this.user , this.item , null ))).then((_)
        {
          setState(() {

          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('就醫紀錄'),centerTitle: true ,),
      body: Padding(
        padding: EdgeInsets.all(10.piw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 55.pih ,
              child: Column( children : [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('歷史紀錄',
                        style: TextStyle(fontSize: 24)),
                  ),
                ),
                Divider(
                  color: Colors.grey[400],
                  height: 10,
                  thickness: 2,
                ),
                _buildDataGrid()
                /*
                SizedBox(
//          height: 60.piw ,
                  width: 80.piw,
               height: 300 ,
               //   height: double.infinity,
                  child: _buildDataGrid(),
                )*/
                ,])
              ),
            // add

            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amber, width: 2),
                    //color: Colors.blueAccent,
                  ),
                  child: IconButton(
                    iconSize: 25,
                    padding: const EdgeInsets.all(5),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.amber,
                    ),
                    onPressed: (){
                      _navigateToAddDoctorScreen(context);
                      // createRecord();
                    },
                  )
              ),
            ),

          ],
        ),
      ),

    );
  }

  final DataGridController _dataGridController = DataGridController();
  Widget _buildDataGrid() {
    return FutureBuilder(
      future: item.getDoctor() ,//getDataFromDatabase(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //var showData = snapshot.data;
          try
          {

            _doctorData.clear();
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            if( false == ( snapshot.data is QuerySnapshot ))
              throw "err" ;
            QuerySnapshot querySnapshot = snapshot.data ;
            // ;
            //      Map<String, dynamic> values = querySnapshot.docs.toList(); ;//snapshot.data!.data() as Map<String, dynamic>;
            //   List<dynamic> key = querySnapshot.docs.toList() ;//values.keys.toList();

            //   for (int i = 0; i < querySnapshot.docs.length; i++)
            for( QueryDocumentSnapshot d in querySnapshot.docs )
            {
              try
              {
                //    final data = values[key[i]];
                TTMDoctor doctor = TTMDoctor.fromSnapshot( d);
                _doctorData.add( doctor );
                /*
              vaccineData.add(Vaccine(
                  data['日期'],
                  data['疫苗']));*/
              }catch( e ){};
            }
          }catch( e )
          {
            return Text( "no data " );
          }

          _vaccineDataSource = DoctorDataSource(_doctorData);
          return Expanded( child : SfDataGrid(
            onCellTap : _onCellTap ,
            columnWidthMode: ColumnWidthMode.fill,
            selectionMode: SelectionMode.single ,
            controller: _dataGridController ,
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
                  columnName: '醫院',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('醫院'))
              ),
              GridColumn(
                  columnName: '問題',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('問題'))
              ),
            ],)
          );
        }
        {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _onCellTap(DataGridCellTapDetails details)
  {
    try  {
      final int index = details.rowColumnIndex.rowIndex - 1 ;
      final TTMDoctor data = _doctorData[index] ;
   //   Widget c = Text( "text" );
      MM.ShowDialog( context , EditDoctor( this.user , this.item , data ) , null , null , false , false ).then((_){ setState(() {

      });} );
/*
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddDoctor( this.user , this.item , data ))).then((_)
      {
        setState(() {

        });
      });*/
    }catch(_){};
  }
}