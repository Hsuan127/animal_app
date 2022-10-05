import '../MM/HYSizeFit.dart';
import 'package:animal_app/TTM/TTMVaccine.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:animal_app/record_page_item/add_vaccine.dart';

import '../MM/MM.dart';
import '../MM/MMWidget.dart';
import '../TTM/TTMItem.dart';
import '../TTM/TTMUser.dart';
import 'edit_vaccine.dart';


//
// 疫苗施打
class VaccinePage extends StatefulWidget {
  //final DatabaseReference firebaseDB = FirebaseDatabase.instance.ref();
  // final String vaccineId;
  //VaccinePage(this.vaccineId);

  final TTMUser user ;
  final TTMItem item ;
  VaccinePage( final TTMUser this.user , final TTMItem this.item );


  @override
  State<StatefulWidget> createState() {
    //createState方法會回傳一個state組件
    return _VaccinePageState( user , item );
    //上述的組件就是這個
  }
}
//void createRecord(){
// Map<DateTime, String> record = {
//   "日期": date,
//   "疫苗": vaccineName,
// };
// firebaseDB.child("vaccine_id").child(id).set(record).whenComplete(() {
//   print("finish set");
//   }).catchError((error){
//   print(error);
// });
//   databaseReference.child("1").set({
//     'date': '2021-11-10',
//     'vaccine': '五合一疫苗'
//   });
//   databaseReference.child("2").set({
//       'date': '2022-03-14',
//       'vaccine': '鉤端螺旋體四價疫苗'
//   });
//
//}
// final List<Vaccine> _vaccines = <Vaccine>[];
// final VaccineDataSource _vaccineDataSource = VaccineDataSource();

class Vaccine {
  Vaccine(this.date, this.name);
  final DateTime date;
  final String name;
}

class VaccineDataSource extends DataGridSource {
  VaccineDataSource(this.vaccineData) {
    _buildDataRow();
  }




  List<DataGridRow> _vaccineData = [];
  List<TTMVaccine> vaccineData;

  void _buildDataRow() {
    _vaccineData = vaccineData
        .map<DataGridRow>((e)
        {
          String dateStr = "${e.date.year}/${e.date.month}/${e.date.day}" ;



          return DataGridRow(cells: [
            DataGridCell<String>(columnName: '日期', value: dateStr),
            DataGridCell<String>(columnName: '疫苗', value: e.name),
          ]);
        })
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
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}
// late VaccineDataSource vaccineRecord;
// List<Vaccine> vaccineData = [];
class _VaccinePageState extends State<VaccinePage>{


  late VaccineDataSource _vaccineDataSource;
  List<TTMVaccine> vaccineData = [];
  List<String> docID = [];
  // final date = DateTime();
  // final name = "";
  final TTMUser user ;
  final TTMItem item ;
  _VaccinePageState( final TTMUser this.user , final TTMItem this.item );

  Future getDataFromDatabase() async {
    // final String documentId;
    //
    //  await FirebaseFirestore.instance.collection('users').get().then(
    //      (snapshot) => snapshot.docs.forEach(
    //              (document){
    //        print(document.reference);
    //        docID.add(document.reference.id);
    //      }),
    //      );
    //
    //  CollectionReference users = FirebaseFirestore.instance.collection('users');
    //  return users.doc
    // return FutureBuilder<DocumentSnapshot>(
    //   builder: ((context, snapshot){
    //     if(snapshot.connectionState == ConnectionState.done){
    //       Map<String, dynamic> data =
    //       snapshot.data!.data() as Map<String, dynamic>;
    //       return Text()
    //     }
    //   }
    //   ),
    // );
    // var value = FirebaseFirestore.instance
    //     .collection('vaccine_id')
    //     .snapshots()
    //     .map((snapshot) => snapshot.docs.map((doc) => doc.data())).toList();
  //  var value = FirebaseDatabase.instance.reference();
  //  var getValue = await value.child('vaccine_id').once();
    return item.getVaccine();
   // return getValue;
  }

  Widget _buildDataGrid() {
    return FutureBuilder(
      future: getDataFromDatabase(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //var showData = snapshot.data;
          try
          {

            vaccineData.clear();
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
                TTMVaccine vaccine = TTMVaccine.fromSnapshot( d);
                vaccineData.add( vaccine );
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

          _vaccineDataSource = VaccineDataSource(vaccineData);
          Widget ret = SfDataGrid(
            columnWidthMode: ColumnWidthMode.fill,
            selectionMode: SelectionMode.single ,
            onCellTap : _onCellTap ,
            source: _vaccineDataSource,
            columns: <GridColumn>[
              GridColumn(
                  columnName: '日期',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(
                        '日期',
                      ))),
              GridColumn(
                  columnName: '疫苗',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('疫苗'))
              ),
            ],
          );

           ret = Expanded( child: ret ,);
          return ret ;
        }
        {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void initState(){
    super.initState();
    getDataFromDatabase();
  }


  void _navigateToAddVaccineScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddVaccine( user , item )))
    .then((_){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    //
    Widget body = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center ,
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

          Padding(
            padding: const EdgeInsets.all(8.0),
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
                    _navigateToAddVaccineScreen(context);
                    // createRecord();
                  },
                )
            ),
          ),


        ],
    ) ;
/*
    body = Container(
        width: double.infinity,
        height: double.infinity,
        child: body ,
    );*/
    body = Padding( padding: EdgeInsets.all(10.piw), child :body);
    //
    return Scaffold(

      appBar:  AppBar(title: Text('疫苗施打'),
      centerTitle: true ,),
 /*
        appBar: AppBar(

          title: MMWidget.newTitleBar(
           null ,// MMWidget.newIconButton( Icons.arrow_back , () => Navigator.of(context).pop() ),
            Text('疫苗施打'),
        ),
        ),*/
      body: body ,

    );
  }


  _onCellTap(DataGridCellTapDetails details)
  {
    try  {
      final int index = details.rowColumnIndex.rowIndex - 1 ;
      final TTMVaccine data = vaccineData[index] ;
      //   Widget c = Text( "text" );
      MM.ShowDialog( context , EditVaccine( this.user , this.item , data ) , null , null , false , false ).then((_){ setState(() {

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